"""
Parser pour les sauvegardes LRX Liberation (Arma 3)
Convertit le format SQF en structures Python exploitables
"""

import re

def parse_sqf_array(sqf_string):
    """
    Convertit une string SQF (format Arma 3) en structure Python
    Gère les arrays imbriqués et les différents types de données
    """
    # Remplace les valeurs spéciales SQF
    sqf_string = sqf_string.strip()
    sqf_string = re.sub(r'\btrue\b', 'True', sqf_string)
    sqf_string = re.sub(r'\bfalse\b', 'False', sqf_string)
    sqf_string = re.sub(r'\bnil\b', 'None', sqf_string)
    
    # Nettoie les notations scientifiques invalides
    sqf_string = re.sub(r'(\d+)e-0?(\d+)', r'\1e-\2', sqf_string)
    
    try:
        # Utilise eval() de manière contrôlée (seulement pour les structures de données)
        result = eval(sqf_string)
        return result
    except Exception as e:
        raise ValueError(f"Erreur lors du parsing SQF: {e}\nContenu: {sqf_string[:200]}...")


class LRXSavegameParser:
    def __init__(self, savegame_data):
        """
        Initialise le parser avec les données brutes du savegame
        savegame_data: liste Python représentant le blob de sauvegarde
        """
        self.raw_data = savegame_data
        self.parsed = {}
        
    def parse(self):
        """Parse l'intégralité du savegame"""
        if len(self.raw_data) < 17:
            raise ValueError(f"Savegame invalide: {len(self.raw_data)} éléments au lieu de 17")
        
        self.parsed = {
            'blufor_sectors': self._parse_sectors(self.raw_data[0]),
            'fobs': self._parse_fobs(self.raw_data[1]),
            'buildings': self._parse_buildings(self.raw_data[2]),
            'time_of_day': self.raw_data[3],
            'combat_readiness': self.raw_data[4],
            'sector_defense': self.raw_data[5],
            'reserved': self.raw_data[6],  # Toujours vide
            'mod_west': self.raw_data[7],
            'mod_east': self.raw_data[8],
            'warehouse': self._parse_warehouse(self.raw_data[9]),
            'stats': self._parse_stats(self.raw_data[10]),
            'weights': self._parse_weights(self.raw_data[11]),
            'vehicle_links': self.raw_data[12],
            'permissions': self._parse_permissions(self.raw_data[13]),
            'player_context': self.raw_data[14],
            'intel': self.raw_data[15],
            'player_scores': self._parse_player_scores(self.raw_data[16])
        }
        return self.parsed
    
    def _parse_sectors(self, sectors):
        """Parse la liste des secteurs Blufor"""
        return [{'name': sector} if isinstance(sector, str) else sector 
                for sector in sectors]
    
    def _parse_fobs(self, fobs):
        """Parse les FOBs (Forward Operating Bases)"""
        parsed_fobs = []
        for fob in fobs:
            if isinstance(fob, list) and len(fob) >= 3:
                parsed_fobs.append({
                    'position': fob  # [x, y, z]
                })
        return parsed_fobs
    
    def _parse_buildings(self, buildings):
        """
        Parse tous les objets sauvegardés
        Format variable selon le type d'objet
        """
        parsed_buildings = []
        
        for building in buildings:
            if not isinstance(building, list) or len(building) < 3:
                continue
                
            obj = {
                'classname': building[0],
                'position': building[1],  # getPosWorld
                'direction': building[2],  # [vectorDir, vectorUp]
            }
            
            # Format de base: [classname, pos, dir]
            if len(building) == 3:
                obj['type'] = 'static'
            
            # Format avec R3F state: [classname, pos, dir, r3f_disabled]
            elif len(building) == 4:
                if isinstance(building[3], bool):
                    obj['type'] = 'static_r3f'
                    obj['r3f_disabled'] = building[3]
                else:
                    # FOB sign: [classname, pos, dir, fob_type, owner]
                    obj['type'] = 'fob_sign'
                    obj['fob_type'] = building[3]
            
            # Format avec owner: [classname, pos, dir, hascrew, owner, ...]
            elif len(building) >= 5:
                obj['has_crew'] = building[3]
                obj['owner'] = building[4]
                
                # Véhicule léger
                if len(building) == 5:
                    obj['type'] = 'light_vehicle'
                
                # Playerbox: [classname, pos, dir, crew, owner, cargo]
                elif len(building) == 6:
                    obj['type'] = 'container'
                    obj['cargo'] = building[5]
                
                # Véhicule complet: [classname, pos, dir, crew, owner, color, color_name, lst_a3, lst_r3f, lst_grl, compo]
                elif len(building) == 11:
                    obj['type'] = 'vehicle'
                    obj['color'] = building[5]
                    obj['color_name'] = building[6]
                    obj['attachments_a3'] = building[7]
                    obj['cargo_r3f'] = building[8]
                    obj['ammo_truck_load'] = building[9]
                    obj['components'] = building[10]
            
            parsed_buildings.append(obj)
        
        return parsed_buildings
    
    def _parse_warehouse(self, warehouse):
        """
        Parse l'entrepôt (ressources disponibles)
        Format: [quantité1, quantité2, ...]
        """
        return {
            'resources': warehouse,
            'total_items': len(warehouse)
        }
    
    def _parse_stats(self, stats):
        """Parse les statistiques de campagne"""
        if len(stats) < 28:
            return {'raw': stats}
        
        return {
            'opfor_soldiers_killed': stats[0],
            'opfor_killed_by_players': stats[1],
            'blufor_soldiers_killed': stats[2],
            'player_deaths': stats[3],
            'opfor_vehicles_killed': stats[4],
            'opfor_vehicles_killed_by_players': stats[5],
            'blufor_vehicles_killed': stats[6],
            'blufor_soldiers_recruited': stats[7],
            'blufor_vehicles_built': stats[8],
            'civilians_killed': stats[9],
            'civilians_killed_by_players': stats[10],
            'sectors_liberated': stats[11],
            'playtime': stats[12],
            'spartan_respawns': stats[13],
            'secondary_objectives': stats[14],
            'hostile_battlegroups': stats[15],
            'ieds_detonated': stats[16],
            'saves_performed': stats[17],
            'saves_loaded': stats[18],
            'reinforcements_called': stats[19],
            'prisoners_captured': stats[20],
            'blufor_teamkills': stats[21],
            'vehicles_recycled': stats[22],
            'ammo_spent': stats[23],
            'sectors_lost': stats[24],
            'fobs_built': stats[25],
            'fobs_lost': stats[26],
            'readiness_earned': stats[27]
        }
    
    def _parse_weights(self, weights):
        """Parse les poids militaires (infantry, armor, air)"""
        if len(weights) >= 3:
            return {
                'infantry': weights[0],
                'armor': weights[1],
                'air': weights[2]
            }
        return {'raw': weights}
    
    def _parse_permissions(self, permissions):
        """
        Parse les permissions des joueurs
        Format: [[uid, [perms]], ...]
        """
        parsed_perms = []
        for perm in permissions:
            if isinstance(perm, list) and len(perm) >= 2:
                parsed_perms.append({
                    'uid': perm[0],
                    'permissions': perm[1]
                })
        return parsed_perms
    
    def _parse_player_scores(self, scores):
        """
        Parse les scores des joueurs
        Format: [[uid, score, ammo, fuel, rank?, name?, ...], ...]
        """
        parsed_scores = []
        for score in scores:
            if isinstance(score, list) and len(score) >= 4:
                player = {
                    'uid': score[0],
                    'score': score[1],
                    'ammo': score[2],
                    'fuel': score[3]
                }
                # Champs optionnels
                if len(score) > 4:
                    player['rank'] = score[4]
                if len(score) > 5:
                    player['name'] = score[5]
                if len(score) > 6:
                    player['extra_data'] = score[6:]
                    
                parsed_scores.append(player)
        return parsed_scores
    
    def get_summary(self):
        """Returns a readable summary of the savegame"""
        if not self.parsed:
            self.parse()
        
        return f"""
╔═══════════════════════════════════════════════════════════════╗
║          LRX LIBERATION SAVEGAME SUMMARY                      ║
╚═══════════════════════════════════════════════════════════════╝

⏰ Time of Day: {self.parsed['time_of_day']}h
⚔️  Combat Readiness: {self.parsed['combat_readiness']}
🎯 Intel: {self.parsed['intel']}

📊 GLOBAL STATISTICS
├─ Saves performed: {self.parsed['stats'].get('saves_performed', 'N/A')}
├─ Total playtime: {self.parsed['stats'].get('playtime', 'N/A')} min
├─ Sectors liberated: {self.parsed['stats'].get('sectors_liberated', 'N/A')}
├─ Sectors lost: {self.parsed['stats'].get('sectors_lost', 'N/A')}
├─ FOBs built: {self.parsed['stats'].get('fobs_built', 'N/A')}
└─ FOBs lost: {self.parsed['stats'].get('fobs_lost', 'N/A')}

🗺️  TERRITORY
├─ Blufor Sectors: {len(self.parsed['blufor_sectors'])}
├─ Active FOBs: {len(self.parsed['fobs'])}
└─ Saved Objects: {len(self.parsed['buildings'])}

👥 ACTIVE PLAYERS: {len(self.parsed['player_scores'])}

⚖️  MILITARY WEIGHTS
├─ Infantry: {self.parsed['weights'].get('infantry', 'N/A')}%
├─ Armor: {self.parsed['weights'].get('armor', 'N/A')}%
└─ Air: {self.parsed['weights'].get('air', 'N/A')}%
"""
    
    def get_detailed_report(self):
        """Generates a complete detailed report"""
        if not self.parsed:
            self.parse()
        
        report = [self.get_summary()]
        
        # Build UID to Name mapping
        uid_to_name = {}
        for player in self.parsed['player_scores']:
            uid = player['uid']
            name = player.get('name', uid[:16])
            uid_to_name[uid] = name
        
        # CAPTURED ZONES
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  CAPTURED ZONES                                               ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        sectors = self.parsed['blufor_sectors']
        for i, sector in enumerate(sectors, 1):
            name = sector if isinstance(sector, str) else sector.get('name', 'Unknown')
            report.append(f"{i:3d}. {name}")
        
        # FOBs
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  DEPLOYED FOBs                                                ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        for i, fob in enumerate(self.parsed['fobs'], 1):
            pos = fob['position']
            report.append(f"FOB #{i}: Position [{pos[0]:.1f}, {pos[1]:.1f}, {pos[2]:.1f}]")
        
        # VEHICLES
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  VEHICLES                                                     ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        vehicles = [b for b in self.parsed['buildings'] if b.get('type') in ['vehicle', 'light_vehicle']]
        
        # Group by owner
        from collections import defaultdict
        by_owner = defaultdict(list)
        for v in vehicles:
            owner = v.get('owner', 'Public/Server')
            by_owner[owner].append(v)
        
        for owner, vlist in sorted(by_owner.items()):
            # Display owner with name if available
            owner_display = f"{uid_to_name.get(owner, owner)}" if owner in uid_to_name else owner
            if owner in uid_to_name and owner != uid_to_name[owner]:
                owner_display = f"{uid_to_name[owner]} ({owner})"
            
            report.append(f"\n👤 Owner: {owner_display}")
            report.append(f"   Vehicles: {len(vlist)}")
            for v in vlist:
                pos = v['position']
                crew = "✓ Crewed" if v.get('has_crew') else "✗ No crew"
                color = f" | Color: {v['color_name']}" if v.get('color_name') else ""
                report.append(f"   • {v['classname']:<40} [{pos[0]:7.1f}, {pos[1]:7.1f}] {crew}{color}")
        
        # STATIC BUILDINGS
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  BUILDINGS & STRUCTURES                                       ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        buildings = [b for b in self.parsed['buildings'] if b.get('type') not in ['vehicle', 'light_vehicle']]
        
        # Count by type
        from collections import Counter
        types_count = Counter([b['classname'] for b in buildings])
        
        report.append(f"Total: {len(buildings)} objects\n")
        for classname, count in types_count.most_common(20):
            report.append(f"{count:4d}x {classname}")
        
        if len(types_count) > 20:
            report.append(f"\n... and {len(types_count) - 20} more types")
        
        # PLAYERS
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  PLAYER STATISTICS                                            ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        players = sorted(self.parsed['player_scores'], key=lambda p: p['score'], reverse=True)
        
        report.append(f"{'#':<4} {'Name/UID':<30} {'Score':>8} {'Ammo':>8} {'Fuel':>8} {'Rank':<10}")
        report.append("─" * 80)
        
        for i, player in enumerate(players, 1):
            name = player.get('name', player['uid'][:16])
            score = player['score']
            ammo = player['ammo']
            fuel = player['fuel']
            rank = player.get('rank', '-')
            report.append(f"{i:<4} {name:<30} {score:>8} {ammo:>8} {fuel:>8} {rank:<10}")
        
        # PERMISSIONS
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  PERMISSIONS                                                  ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        perm_labels = ['Build', 'Logistics', 'Manage', 'Airlift', 'Halo', 'Arsenal']
        
        report.append(f"{'Name (UID/Group)':<40} {' '.join([f'{p:>8}' for p in perm_labels])}")
        report.append("─" * 90)
        
        for perm in self.parsed['permissions']:
            uid = perm['uid']
            perms = perm['permissions']
            
            # Display with name if available
            if uid in uid_to_name and uid != uid_to_name[uid]:
                display_name = f"{uid_to_name[uid]} ({uid})"
            else:
                display_name = uid
            
            if isinstance(perms, list) and len(perms) >= 6:
                perm_str = ' '.join([f"{'✓':>8}" if p else f"{'✗':>8}" for p in perms])
                report.append(f"{display_name:<40} {perm_str}")
        
        # COMBAT STATISTICS
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  COMBAT STATISTICS                                            ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        stats = self.parsed['stats']
        combat_stats = [
            ("Enemies killed", stats.get('opfor_soldiers_killed', 0)),
            ("  └─ By players", stats.get('opfor_killed_by_players', 0)),
            ("Enemy vehicles destroyed", stats.get('opfor_vehicles_killed', 0)),
            ("  └─ By players", stats.get('opfor_vehicles_killed_by_players', 0)),
            ("", ""),
            ("Blufor soldiers killed", stats.get('blufor_soldiers_killed', 0)),
            ("Player deaths", stats.get('player_deaths', 0)),
            ("Blufor vehicles destroyed", stats.get('blufor_vehicles_killed', 0)),
            ("Blufor teamkills", stats.get('blufor_teamkills', 0)),
            ("", ""),
            ("Civilians killed", stats.get('civilians_killed', 0)),
            ("  └─ By players", stats.get('civilians_killed_by_players', 0)),
            ("", ""),
            ("IEDs detonated", stats.get('ieds_detonated', 0)),
            ("Prisoners captured", stats.get('prisoners_captured', 0)),
            ("Ammo spent", stats.get('ammo_spent', 0)),
        ]
        
        for label, value in combat_stats:
            if label == "":
                report.append("")
            else:
                report.append(f"{label:<40} {value:>10,}")
        
        # PRODUCTION
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  PRODUCTION & LOGISTICS                                       ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        prod_stats = [
            ("Soldiers recruited", stats.get('blufor_soldiers_recruited', 0)),
            ("Vehicles built", stats.get('blufor_vehicles_built', 0)),
            ("Vehicles recycled", stats.get('vehicles_recycled', 0)),
            ("Reinforcements called", stats.get('reinforcements_called', 0)),
            ("Spartan respawns", stats.get('spartan_respawns', 0)),
            ("Combat Readiness earned", stats.get('readiness_earned', 0)),
        ]
        
        for label, value in prod_stats:
            report.append(f"{label:<40} {value:>10,}")
        
        # WAREHOUSE
        report.append("\n╔═══════════════════════════════════════════════════════════════╗")
        report.append("║  WAREHOUSE                                                    ║")
        report.append("╚═══════════════════════════════════════════════════════════════╝\n")
        
        warehouse = self.parsed['warehouse']['resources']
        resource_names = ['Water Barrels', 'Fuel Barrels', 'Food Pallets', 'Weapon Boxes']
        
        if len(warehouse) > 0:
            report.append("Resources in stock:\n")
            for i, (name, qty) in enumerate(zip(resource_names, warehouse)):
                if i < len(warehouse):
                    report.append(f"  • {name:<20} {qty:>6,}")
            
            # Additional items if any
            if len(warehouse) > 4:
                report.append(f"\n  + {len(warehouse) - 4} other item types")
        else:
            report.append("Warehouse is empty")
        
        return '\n'.join(report)

    def export_to_json(self):
        """Exporte en JSON (nécessite import json)"""
        import json
        if not self.parsed:
            self.parse()
        return json.dumps(self.parsed, indent=2, ensure_ascii=False)


# === EXEMPLE D'UTILISATION ===
if __name__ == "__main__":
    import argparse
    import sys
    
    parser_cmd = argparse.ArgumentParser(
        description='Parse an LRX Liberation savegame file (Arma 3)',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python lrx_parser.py savegame.sqf
  python lrx_parser.py savegame.sqf --output result.json
  python lrx_parser.py savegame.sqf --summary
  python lrx_parser.py savegame.sqf --players
        """
    )
    
    parser_cmd.add_argument('fichier', help='Savegame file (SQF or JSON format)')
    parser_cmd.add_argument('-o', '--output', help='Output JSON file (optional)')
    parser_cmd.add_argument('-s', '--summary', action='store_true', help='Display summary only')
    parser_cmd.add_argument('-p', '--players', action='store_true', help='Display players only')
    parser_cmd.add_argument('-v', '--vehicles', action='store_true', help='Display vehicles only')
    parser_cmd.add_argument('-b', '--buildings', action='store_true', help='Display buildings only')
    
    args = parser_cmd.parse_args()
    
    # Read file
    try:
        with open(args.fichier, 'r', encoding='utf-8') as f:
            raw_content = f.read().strip()
        print(f"✓ File loaded: {args.fichier} ({len(raw_content)} characters)\n")
    except FileNotFoundError:
        print(f"✗ Error: file '{args.fichier}' not found")
        sys.exit(1)
    except Exception as e:
        print(f"✗ Read error: {e}")
        sys.exit(1)
    
    # Format detection and parsing
    try:
        if raw_content.startswith('['):
            # SQF format
            print("Detected format: SQF")
            savegame_data = parse_sqf_array(raw_content)
        else:
            # Try JSON
            import json
            print("Detected format: JSON")
            savegame_data = json.loads(raw_content)
    except Exception as e:
        print(f"✗ Parsing error: {e}")
        sys.exit(1)
    
    # Parse savegame
    try:
        parser = LRXSavegameParser(savegame_data)
        result = parser.parse()
        print("✓ Savegame parsed successfully!\n")
    except Exception as e:
        print(f"✗ Analysis error: {e}")
        import traceback
        traceback.print_exc()
        sys.exit(1)
    
    # Display based on options
    if args.summary:
        print(parser.get_summary())
    
    elif args.players:
        print("╔═══════════════════════════════════════════════════════════════╗")
        print("║  PLAYERS                                                      ║")
        print("╚═══════════════════════════════════════════════════════════════╝\n")
        
        players = sorted(result['player_scores'], key=lambda p: p['score'], reverse=True)
        
        print(f"{'#':<4} {'Name/UID':<30} {'Score':>8} {'Ammo':>8} {'Fuel':>8} {'Rank':<10}")
        print("─" * 80)
        
        for i, player in enumerate(players, 1):
            name = player.get('name', player['uid'][:16])
            score = player['score']
            ammo = player['ammo']
            fuel = player['fuel']
            rank = player.get('rank', '-')
            print(f"{i:<4} {name:<30} {score:>8} {ammo:>8} {fuel:>8} {rank:<10}")
    
    elif args.vehicles:
        print("╔═══════════════════════════════════════════════════════════════╗")
        print("║  VEHICLES                                                     ║")
        print("╚═══════════════════════════════════════════════════════════════╝\n")
        
        vehicles = [b for b in result['buildings'] if b.get('type') in ['vehicle', 'light_vehicle']]
        print(f"Total: {len(vehicles)} vehicles\n")
        
        # Build UID to Name mapping
        uid_to_name = {}
        for player in result['player_scores']:
            uid = player['uid']
            name = player.get('name', uid[:16])
            uid_to_name[uid] = name
        
        from collections import defaultdict
        by_owner = defaultdict(list)
        for v in vehicles:
            owner = v.get('owner', 'Public/Server')
            by_owner[owner].append(v)
        
        for owner, vlist in sorted(by_owner.items()):
            # Display owner with name if available
            if owner in uid_to_name and owner != uid_to_name[owner]:
                owner_display = f"{uid_to_name[owner]} ({owner})"
            else:
                owner_display = owner
            
            print(f"\n👤 Owner: {owner_display} ({len(vlist)} vehicles)")
            for v in vlist:
                pos = v['position']
                crew = "✓" if v.get('has_crew') else "✗"
                color = f" | {v['color_name']}" if v.get('color_name') else ""
                print(f"   [{crew}] {v['classname']:<40} [{pos[0]:7.1f}, {pos[1]:7.1f}]{color}")
    
    elif args.buildings:
        print("╔═══════════════════════════════════════════════════════════════╗")
        print("║  BUILDINGS                                                    ║")
        print("╚═══════════════════════════════════════════════════════════════╝\n")
        
        buildings = [b for b in result['buildings'] if b.get('type') not in ['vehicle', 'light_vehicle']]
        print(f"Total: {len(buildings)} objects\n")
        
        from collections import Counter
        types_count = Counter([b['classname'] for b in buildings])
        for classname, count in types_count.most_common():
            print(f"{count:4d}x {classname}")
    
    else:
        # Full detailed display
        print(parser.get_detailed_report())
    
    # Export if requested
    if args.output:
        try:
            import json
            with open(args.output, 'w', encoding='utf-8') as f:
                json.dump(result, f, indent=2, ensure_ascii=False)
            print(f"\n✓ Results exported to: {args.output}")
        except Exception as e:
            print(f"✗ Export error: {e}")
            sys.exit(1)