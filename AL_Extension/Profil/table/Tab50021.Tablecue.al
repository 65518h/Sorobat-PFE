table 50021 "Table cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Cle Primaire"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Nombre de Salarié Actif"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee WHERE(Blocked = CONST(False), BR = CONST(False)));
        }
        field(3; "Total Salaire Net"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*')));
        }
        field(4; "Nombre de Salarié Calcul Paie"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Salary Lines" WHERE("No." = filter('PAI*')));
        }
        field(5; "Nombre de Salarié Bloqué"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee WHERE(Blocked = CONST(True)));
        }
        field(6; "Nombre de Salarié BR"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Employee WHERE(Blocked = CONST(False), BR = CONST(True)));
        }
        field(7; "Total Salaire Brut"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Salary Lines"."Gross Salary" WHERE("No." = filter('PAI*')));
        }
        //Caisse 
        field(8; "Solde Caisse Central"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = - sum("Payment Line".Amount where(Caisse = const(true)));
        }
        field(9; "AEROPORT_DONSIN"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('AEROPORT_DONSIN')));
        }
        field(10; "CARRIERE_BOBO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CARRIERE_BOBO')));
        }
        field(11; "CARRIERE_NIAOGHO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CARRIERE_NIAOGHO')));
        }
        field(12; "CARRIERE_NIGUI"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CARRIERE_NIGUI')));
        }
        field(13; "CARRIERE_NINGUI"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CARRIERE_NINGUI')));
        }
        field(14; "CARRIEREBOUDRI"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CARRIEREBOUDRI')));
        }
        field(15; "CYANKASOU"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CYANKASOU')));
        }
        field(16; "DRAIN-TANGHIN"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('DRAIN-TANGHIN')));
        }
        field(17; "LOMBELA"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOMBELA')));
        }
        field(18; "LOT13-0001"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOT13-0001')));
        }
        field(19; "LOT1-KOP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOT1-KOP')));
        }
        field(20; "LOT2-TKD"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOT2-TKD')));
        }
        field(91; "LOT3-BITOU"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOT3-BITOU')));
        }
        field(92; "LOTNOUNA"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOTNOUNA')));
        }
        field(93; "NORD OUAGA"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('NORD OUAGA')));
        }
        field(94; "OUAGA TANGHIN"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('OUAGA TANGHIN')));
        }
        field(95; "PCENTRAL"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('PCENTRAL')));
        }
        field(96; "RN-04"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-04')));
        }
        field(97; "RN-04 FADA"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-04 FADA')));
        }
        field(98; "RN-04 LOT1 GOUNGHIN"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-04 LOT1 GOUNGHIN')));
        }
        field(99; "RN10"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN10')));
        }
        field(100; "RN-14"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-14')));
        }
        field(101; "RN-17"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-17')));
        }
        field(102; "RN17/TKD-ORG"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN17/TKD-ORG')));
        }
        field(103; "RN19"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN19')));
        }
        field(104; "RN-22"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-22')));
        }
        field(105; "RN-22/KON-DJI"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-22/KON-DJI')));
        }
        field(106; "RR-06/32"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RR-06/32')));
        }
        field(107; "RR-29"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RR-29')));
        }
        field(108; "SGSOCIAL"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('SGSOCIAL')));
        }
        field(109; "STOCK"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('STOCK')));
        }
        field(110; "TRANSPORT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('TRANSPORT')));
        }
        field(111; "VENTE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('VENTE')));
        }
        field(112; "DAPELOGO-CENTRAL ENR"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('DAPELOGO-CENTRAL ENR')));
        }

        field(113; "CHANTIER NAGRIN"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CHANTIER NAGRIN')));
        }
        //Facturation ------------------------------------------------
        field(21; "Nbre Factures en instance"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Invoice), "Facture En Instance" = const(true)));
        }
        //Achat-------------------------------------------------------
        field(22; "Nbr Commande  "; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order))); //total
        }
        field(23; "Nbr Commande Lance "; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Status" = const(1)));
        }
        field(24; "Nbr Commande Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Status" = const(0)));
        }
        field(25; "Nbr Cmd attente aprobation   "; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Status" = const(2)));
        }
        field(26; "Nbr Cmd Archive  "; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Status" = const(4)));
        }
        field(27; "Nbr DA OUVERT-LANCé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Request" WHERE("Statut" = filter(<> 2 & <> 3 & <> 7)));
        }
        field(28; "Nbr DA Approuvé"; Integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count("Purchase Request" WHERE("Statut" = const(7)));
            CalcFormula = count("Purchase Request" WHERE("Statut" = filter(<> 0 & <> 1 & <> 4 & <> 5 & <> 6)));
        }
        field(29; "Nbr DA Commandé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Request" WHERE("Statut" = const(3)));
        }
        field(30; "Nbr Fiche Gasoil en cours"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0)));
        }
        field(31; "Nbr Fiche Gasoil Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1)));
        }
        field(32; "Nbr Mvt Magasin CARRIERE_BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('CARRIERE_BOBO'), "Item No." = filter(<> '3000010000001')));
        }
        field(33; "Nbr Mvt PCENTRAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('PCENTRAL'), "Item No." = filter(<> '3000010000001')));



        }
        field(34; "Nbr Mvt Magasin CARRIERE_NIAOGHO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('CARRIERE_NIAOGHO'), "Item No." = filter(<> '3000010000001')));
        }
        field(35; "Nbr Mvt CARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('CARRIERE_NIGUI'), "Item No." = filter(<> '3000010000001')));
        }
        field(36; "Nbr Ligne Gasoil Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Ligne Fiche Gasoil" WHERE("Statut" = const(1)));
        }
        field(37; "Nbr Mvt Magasin RN-04 FADA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('RN-04 FADA'), "Item No." = filter(<> '3000010000001')));
        }
        field(38; "Nbr Mvt Magasin RN-04 LOT1 GOUNGHIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('RN-04 LOT1 GOUNGHIN'), "Item No." = filter(<> '3000010000001')));
        }
        field(39; "Nbr Pointage Vehicule en cours"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0)));
        }
        field(40; "Nbr Pointage Vehicule Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1)));
        }
        field(41; "Nbr Transfert Engin en cours"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Historique Transfert Engin" WHERE(Status = const(0)));
        }
        field(42; "Nbr Transfert Engin lancé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Historique Transfert Engin" WHERE(Status = const(1)));
        }
        field(43; "Nbr Vehicule PARC CENTRAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('PCENTRAL'), Bloquer = const(False)));
        }
        field(44; "Nbr Vehicule RN-04 FADA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('RN-04 FADA'), Bloquer = const(False)));
        }
        field(45; "Nbr Vehicule RN-14"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('RN-14'), Bloquer = const(False)));
        }
        field(46; "Nbr Vehicule RN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('RN-22/KON-DJI'), Bloquer = const(False)));
        }
        field(47; "Nbr Vehicule PENLOT3"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('PENETRANTE_LOT3'), Bloquer = const(False)));
        }



        /// <summary>
        field(61; "Nbr Vehicule CARRIERE_BOBO"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CARRIERE_BOBO'), Bloquer = const(False)));
        }
        field(62; "Nbr VehiculeCARRIERE_NIAOGHO"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CARRIERE_NIAOGHO'), Bloquer = const(False)));
        }
        field(63; "Nbr VehiculeCARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CARRIERE_NIGUI'), Bloquer = const(False)));
        }
        field(64; "Nbr VehiculeCARRIERE_NINGUI"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CARRIERE_NINGUI'), Bloquer = const(False)));
        }
        field(90; "Nbr VehiculeCARRIEREBOUDRI"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CARRIEREBOUDRI'), Bloquer = const(False)));
        }
        field(148; "Nbr VehiculeCYANKASOU"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CYANKASOU'), Bloquer = const(False)));
        }
        field(149; "Nbr VehiculeDRAIN-TANGHIN"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('DRAIN-TANGHIN'), Bloquer = const(False)));
        }
        field(150; "Nbr VehiculeLOMBELA"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOMBELA'), Bloquer = const(False)));
        }
        field(151; "Nbr VehiculeLOT13-0001"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOT13-0001'), Bloquer = const(False)));
        }
        field(152; "Nbr VehiculeLOT1-KOP"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOT1-KOP'), Bloquer = const(False)));
        }
        field(153; "Nbr VehiculeLOT2-TKD"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOT2-TKD'), Bloquer = const(False)));
        }
        field(154; "Nbr VehiculeLOT3-BITOU"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOT3-BITOU'), Bloquer = const(False)));
        }
        field(155; "Nbr VehiculeLOTNOUNA"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOTNOUNA'), Bloquer = const(False)));
        }
        field(156; "Nbr VehiculeNORD OUAGA"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('NORD OUAGA'), Bloquer = const(False)));
        }
        field(157; "Nbr VehiculeOUAGA TANGHIN"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('OUAGA TANGHIN'), Bloquer = const(False)));
        }
        field(158; "Nbr VehiculePCENTRAL"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('PCENTRAL'), Bloquer = const(False)));
        }
        field(159; "Nbr VehiculeRN-04"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN-04'), Bloquer = const(False)));
        }
        field(160; "Nbr VehiculeRN-04 FADA"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN-04 FADA'), Bloquer = const(False)));
        }
        field(161; "Nbr VehiculeRN-04 LOT1 GOUNGHIN"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN-04 LOT1 GOUNGHIN'), Bloquer = const(False)));
        }
        field(162; "Nbr VehiculeRN10"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN10'), Bloquer = const(False)));
        }
        field(163; "Nbr VehiculeRN-14"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('RN-14')));

        }
        field(164; "Nbr VehiculeRN-17"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN-17'), Bloquer = const(False)));
        }
        field(165; "Nbr VehiculeRN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN17/TKD-ORG'), Bloquer = const(False)));
        }

        field(166; "Nbr VehiculeRN19"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN19'), Bloquer = const(False)));
        }
        field(167; "Nbr VehiculeRN-22"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN-22'), Bloquer = const(False)));
        }
        field(168; "Nbr VehiculeRN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RN-22/KON-DJI'), Bloquer = const(False)));
        }
        field(169; "Nbr VehiculeRR-06/32"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RR-06/32'), Bloquer = const(False)));
        }

        field(170; "Nbr VehiculeRR-29"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('RR-29'), Bloquer = const(False)));
        }
        field(171; "Nbr VehiculeSGSOCIAL"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('SGSOCIAL'), Bloquer = const(False)));
        }
        field(172; "Nbr VehiculeSTOCK"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('STOCK'), Bloquer = const(False)));
        }
        field(173; "Nbr VehiculeTRANSPORT"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('TRANSPORT'), Bloquer = const(False)));
        }
        field(174; "Nbr VehiculeVENTE"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('VENTE'), Bloquer = const(False)));
        }
        field(175; "Nbr VehiculeDAPELOGO-CENTRAL ENR"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('DAPELOGO-CENTRAL ENR'), Bloquer = const(False)));
        }

        field(176; "Nbr VehiculeLOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('LOT 4 RN22'), Bloquer = const(False)));
        }
        field(177; "LOT 4 RN22"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('LOT 4 RN22')));
        }

        field(178; "Réparation Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false)));
        }

        field(179; "Réparation Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true)));
        }



        field(180; "Nbr Mvt Magasin RR-06/32"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('RR-06/32'), "Item No." = filter(<> '3000010000001')));

        }

        field(181; "Nbr Mvt Magasin DAPELOGO-CENTRAL ENR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('DAPELOGO-CENTRAL ENR'), "Item No." = filter(<> '3000010000001')));

        }


        field(182; "Nbr Mvt Magasin LOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('LOT 4 RN22'), "Item No." = filter(<> '3000010000001')));

        }
        field(183; "Nbr Mvt Magasin SGSOCIAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('SGSOCIAL'), "Item No." = filter(<> '3000010000001')));

        }
        field(184; "Nbr Mvt Magasin TRANSPORT"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('TRANSPORT'), "Item No." = filter(<> '3000010000001')));

        }

        field(185; "Nbr VehiculeCHANTIER NAGRIN"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CHANTIER NAGRIN'), Bloquer = const(False)));
        }




        field(186; "Nbr Factures achat"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Invoice)));
        }
        field(187; "Nbr Facture achat enregistrée"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purch. Inv. Header");
        }


        field(188; "CHANTIER-BOBO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Payment Line".Amount WHERE("Caisse Chantier" = CONST(true), "N° Affaire" = CONST('CHANTIER-BOBO')));
        }


        /// </summary>

        field(189; "Nbr Vehicule CHANTIER-BOBO"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = count(Véhicule WHERE(Marche = const('CHANTIER-BOBO'), Bloquer = const(False)));
        }



        field(190; "Nbr Fiche Gasoil en cours PCENTRAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('PCENTRAL')));
        }
        field(191; "Nbr Fiche Gasoil en cours CARRIERE_BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('CARRIERE_BOBO')));
        }
        field(204; "Nbr Fiche Gasoil en cours CHANTIER-BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('CHANTIER-BOBO')));
        }


        field(192; "Nbr Fiche Gasoil en cours CARRIERE_NIAOGHO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('CARRIERE_NIAOGHO')));
        }


        field(193; "Nbr Fiche Gasoil en cours CARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('CARRIERE_NIGUI')));
        }


        field(194; "Nbr Fiche Gasoil en cours RN-04 FADA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('RN-04 FADA')));
        }


        field(195; "Nbr Fiche Gasoil en cours RN-04 LOT1 GOUNGHIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('RN-04 LOT1 GOUNGHIN')));
        }


        field(196; "Nbr Fiche Gasoil en cours RN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('RN17/TKD-ORG')));
        }


        field(197; "Nbr Fiche Gasoil en cours LOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('LOT 4 RN22')));
        }


        field(198; "Nbr Fiche Gasoil en cours RN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('RN-22/KON-DJI')));
        }


        field(199; "Nbr Fiche Gasoil en cours RR-06/32"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('RR-06/32')));
        }


        field(200; "Nbr Fiche Gasoil en cours DAPELOGO-CENTRAL ENR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('DAPELOGO-CENTRAL ENR')));
        }


        field(201; "Nbr Fiche Gasoil en cours CHANTIER NAGRIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('CHANTIER NAGRIN')));
        }


        field(202; "Nbr Fiche Gasoil en cours SGSOCIAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('SGSOCIAL')));
        }


        field(203; "Nbr Fiche Gasoil en cours TRANSPORT"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(0), Chantier = const('TRANSPORT')));
        }














        field(205; "Nbr Fiche Gasoil Validé PCENTRAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('PCENTRAL')));
        }
        field(206; "Nbr Fiche Gasoil Validé CARRIERE_BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('CARRIERE_BOBO')));
        }
        field(207; "Nbr Fiche Gasoil Validé CHANTIER-BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('CHANTIER-BOBO')));
        }


        field(208; "Nbr Fiche Gasoil Validé CARRIERE_NIAOGHO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('CARRIERE_NIAOGHO')));
        }


        field(209; "Nbr Fiche Gasoil Validé CARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('CARRIERE_NIGUI')));
        }


        field(210; "Nbr Fiche Gasoil Validé RN-04 FADA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('RN-04 FADA')));
        }


        field(211; "Nbr Fiche Gasoil Validé RN-04 LOT1 GOUNGHIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('RN-04 LOT1 GOUNGHIN')));
        }


        field(212; "Nbr Fiche Gasoil Validé RN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('RN17/TKD-ORG')));
        }


        field(213; "Nbr Fiche Gasoil Validé LOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('LOT 4 RN22')));
        }


        field(214; "Nbr Fiche Gasoil Validé RN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('RN-22/KON-DJI')));
        }


        field(215; "Nbr Fiche Gasoil Validé RR-06/32"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('RR-06/32')));
        }


        field(216; "Nbr Fiche Gasoil Validé DAPELOGO-CENTRAL ENR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('DAPELOGO-CENTRAL ENR')));
        }


        field(217; "Nbr Fiche Gasoil Validé CHANTIER NAGRIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('CHANTIER NAGRIN')));
        }


        field(218; "Nbr Fiche Gasoil Validé SGSOCIAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('SGSOCIAL')));
        }


        field(219; "Nbr Fiche Gasoil Validé TRANSPORT"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Fiche Gasoil" WHERE("Statut" = const(1), Chantier = const('TRANSPORT')));
        }











        field(220; "Nbr Pointage Vehicule en cours PCENTRAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('PCENTRAL')));
        }
        field(221; "Nbr Pointage Vehicule Validé PCENTRAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('PCENTRAL')));
        }

        field(223; "Nbr Pointage Vehicule en cours CARRIERE_BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('CARRIERE_BOBO')));
        }
        field(224; "Nbr Pointage Vehicule Validé CARRIERE_BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('CARRIERE_BOBO')));
        }

        field(225; "Nbr Pointage Vehicule en cours CHANTIER-BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('CHANTIER-BOBO')));
        }
        field(226; "Nbr Pointage Vehicule Validé CHANTIER-BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('CHANTIER-BOBO')));
        }


        field(227; "Nbr Pointage Vehicule en cours CARRIERE_NIAOGHO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('CARRIERE_NIAOGHO')));
        }
        field(228; "Nbr Pointage Vehicule Validé CARRIERE_NIAOGHO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('CARRIERE_NIAOGHO')));
        }
        field(229; "Nbr Pointage Vehicule en cours CARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('CARRIERE_NIGUI')));
        }
        field(230; "Nbr Pointage Vehicule Validé CARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('CARRIERE_NIGUI')));
        }

        field(231; "Nbr Pointage Vehicule en cours RN-04 FADA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('RN-04 FADA')));
        }
        field(232; "Nbr Pointage Vehicule Validé RN-04 FADA"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('RN-04 FADA')));
        }
        field(233; "Nbr Pointage Vehicule en cours RN-04 LOT1 GOUNGHIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('RN-04 LOT1 GOUNGHIN')));
        }
        field(234; "Nbr Pointage Vehicule Validé RN-04 LOT1 GOUNGHIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('RN-04 LOT1 GOUNGHIN')));
        }


        field(235; "Nbr Pointage Vehicule en cours RN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('RN17/TKD-ORG')));
        }
        field(237; "Nbr Pointage Vehicule Validé RN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('RN17/TKD-ORG')));
        }

        field(236; "Nbr Pointage Vehicule en cours LOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('LOT 4 RN22')));
        }
        field(238; "Nbr Pointage Vehicule Validé LOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('LOT 4 RN22')));
        }

        field(239; "Nbr Pointage Vehicule en cours RN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('RN-22/KON-DJI')));
        }
        field(240; "Nbr Pointage Vehicule Validé RN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('RN-22/KON-DJI')));
        }

        field(241; "Nbr Pointage Vehicule en cours RR-06/32"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('RR-06/32')));
        }
        field(242; "Nbr Pointage Vehicule Validé RR-06/32"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('RR-06/32')));
        }

        field(243; "Nbr Pointage Vehicule en cours DAPELOGO-CENTRAL ENR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('DAPELOGO-CENTRAL ENR')));
        }
        field(244; "Nbr Pointage Vehicule Validé DAPELOGO-CENTRAL ENR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('DAPELOGO-CENTRAL ENR')));
        }

        field(245; "Nbr Pointage Vehicule en cours CHANTIER NAGRIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('CHANTIER NAGRIN')));
        }
        field(246; "Nbr Pointage Vehicule Validé CHANTIER NAGRIN"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('CHANTIER NAGRIN')));
        }

        field(247; "Nbr Pointage Vehicule en cours SGSOCIAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('SGSOCIAL')));
        }
        field(248; "Nbr Pointage Vehicule Validé SGSOCIAL"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('SGSOCIAL')));
        }


        field(249; "Nbr Pointage Vehicule en cours TRANSPORT"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(0), Marche = const('TRANSPORT')));
        }
        field(250; "Nbr Pointage Vehicule Validé TRANSPORT"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Entete Pointage Vehicule" WHERE(Statut = const(1), Marche = const('TRANSPORT')));
        }



        //Réparation

        field(251; "Réparation PCENTRAL Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('PCENTRAL')));
        }

        field(252; "Réparation PCENTRAL Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('PCENTRAL')));
        }


        field(253; "Réparation CARRIERE_BOBO Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('CARRIERE_BOBO')));
        }

        field(254; "Réparation CARRIERE_BOBO Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('CARRIERE_BOBO')));
        }
        field(255; "Réparation CHANTIER-BOBO Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('CHANTIER-BOBO')));
        }

        field(256; "Réparation CHANTIER-BOBO Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('CHANTIER-BOBO')));
        }


        field(257; "Réparation CARRIERE_NIAOGHO Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('CARRIERE_NIAOGHO')));
        }

        field(258; "Réparation CARRIERE_NIAOGHO Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('CARRIERE_NIAOGHO')));
        }

        field(259; "Réparation CARRIERE_NIGUI Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('CARRIERE_NIGUI')));
        }

        field(260; "Réparation CARRIERE_NIGUI Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('CARRIERE_NIGUI')));
        }

        field(261; "Réparation RN-04 FADA Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('RN-04 FADA')));
        }

        field(262; "Réparation RN-04 FADA Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('RN-04 FADA')));
        }

        field(263; "Réparation RN-04 LOT1 GOUNGHIN Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('RN-04 LOT1 GOUNGHIN')));
        }

        field(264; "Réparation RN-04 LOT1 GOUNGHIN Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('RN-04 LOT1 GOUNGHIN')));
        }


        field(265; "Réparation RN17/TKD-ORG Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('RN17/TKD-ORG')));
        }

        field(266; "Réparation RN17/TKD-ORG Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('RN17/TKD-ORG')));
        }

        field(267; "Réparation LOT 4 RN22 Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('LOT 4 RN22')));
        }

        field(268; "Réparation LOT 4 RN22 Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('LOT 4 RN22')));
        }


        field(269; "Réparation RN-22/KON-DJI Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('RN-22/KON-DJI')));
        }

        field(270; "Réparation RN-22/KON-DJI Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('RN-22/KON-DJI')));
        }


        field(271; "Réparation RR-06/32 Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('RR-06/32')));
        }

        field(272; "Réparation RR-06/32 Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('RR-06/32')));
        }

        field(273; "Réparation DAPELOGO-CENTRAL ENR Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('DAPELOGO-CENTRAL ENR')));
        }

        field(274; "Réparation DAPELOGO-CENTRAL ENR Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('DAPELOGO-CENTRAL ENR')));
        }

        field(275; "Réparation CHANTIER NAGRIN Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('CHANTIER NAGRIN')));
        }

        field(276; "Réparation CHANTIER NAGRIN Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('CHANTIER NAGRIN')));
        }

        field(277; "Réparation SGSOCIAL Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('SGSOCIAL')));
        }

        field(278; "Réparation SGSOCIAL Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('SGSOCIAL')));
        }


        field(280; "Réparation TRANSPORT Ouvert"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(false), Affectation = const('TRANSPORT')));
        }

        field(281; "Réparation TRANSPORT Validé"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Réparation Véhicule" WHERE(Valider = const(true), Affectation = const('TRANSPORT')));
        }
        //


















































































        field(48; "TOUT les Mouvements Articles"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Item No." = filter(<> '3000010000001')));
        }
        field(49; "Nbr Mvt Magasin RN-22/KON-DJI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('RN-22/KON-DJI'), "Item No." = filter(<> '3000010000001')));

        }
        field(50; "Nbr Mvt Magasin RN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;


            CalcFormula = count("Item Ledger Entry" WHERE("Job No." = const('RN17/TKD-ORG'), "Item No." = filter(<> '3000010000001')));
        }
        /*  field(51; "Total Salaire Net Sbikha"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('AUTOROUTE SBIKHA LO5')));

          }

          field(52; "Total Salaire Net KEF_RR173"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('CHANTIER_KEF_RR173')));

          }

          field(53; "Total Salaire Net BIZERTE_BASE_AERIEN"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('BIZERTE_BASE_AERIEN')));

          }

          field(54; "Total Salaire Net PENETRANTE_LOT2"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PENETRANTE_LOT2')));

          }

          field(55; "Total Salaire Net PENETRANTE_LOT3"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PENETRANTE_LOT3')));

          }

          field(56; "Total Salaire Net PONT_BIZERTE_LOT1"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PONT_BIZERTE_LOT1')));

          }

          field(57; "Total Salaire Net PORT FINA RAOUED RP2"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PORT FINA RAOUED RP2')));

          }
          field(58; "Total Salaire Net RFR LOT1"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('RFR LOT1')));

          }

          field(59; "Total Salaire Net OUED_JOUMINE_MATEUR"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('OUED_JOUMINE_MATEUR')));

          }

          field(60; "Total Salaire Net MEDJERDA BOUSALEM"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('MEDJERDA BOUSALEM')));

          }

          field(61; "Total Salaire Net RVE719BOUSSADIA"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('RVE719BOUSSADIA')));

          }

          field(62; "Total Salaire Autres Affectation"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter(<> 'AUTOROUTE SBIKHA LO5' & <> 'CHANTIER_KEF_RR173' & <> 'BIZERTE_BASE_AERIEN' & <> 'PENETRANTE_LOT2' & <> 'PENETRANTE_LOT3' & <> 'PONT_BIZERTE_LOT1' & <> 'PORT FINA RAOUED RP2' & <> 'RFR LOT1' & <> 'OUED_JOUMINE_MATEUR' & <> 'MEDJERDA BOUSALEM' & <> 'RVE719BOUSSADIA' & <> 'DEPOT Z4' & <> 'ADMINISTRATION' & <> 'ADMINISTRATION_EXTEN')));

          }

          field(63; "Total Salaire DEPOT Z4"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('DEPOT Z4')));

          }

          field(64; "Total Salaire ADMINISTRATIONS"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('ADMINISTRATION' | 'ADMINISTRATION_EXTEN')));

          }*/
        field(65; "Decompte"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line"."Shipped Not Invoiced" where("Document Type" = const(Order), "Structure Line No." = const(0), "Line Type" = filter(<> Other), "Document No." = filter('CMDV-02-24/000359')));
        }
        /*  field(66; "Total Salaire ADMINISTRATIONS Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('ADMINISTRATION' | 'ADMINISTRATION_EXTEN')));

          }*/
        field(67; "Nbr Vehicule Bizerte Pont"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('PONT_BIZERTE_LOT1'), Bloquer = const(False)));
        }
        field(68; "Nbr Vehicule OUED JOUMINE MATEUR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('OUED_JOUMINE_MATEUR'), Bloquer = const(False)));
        }
        field(69; "Nbr Vehicule KEF RR173"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Véhicule WHERE(Marche = const('CHANTIER_KEF_RR173'), Bloquer = const(False)));
        }
        /*  field(70; "Total Salaire Net Sbikha Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('AUTOROUTE SBIKHA LO5')));

          }

          field(71; "Total Salaire Net KEF_RR173 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('CHANTIER_KEF_RR173')));

          }

          field(72; "Total Salaire Net BIZERTE_BASE_AERIEN Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('BIZERTE_BASE_AERIEN')));

          }

          field(73; "Total Salaire Net PENETRANTE_LOT2 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PENETRANTE_LOT2')));

          }

          field(74; "Total Salaire Net PENETRANTE_LOT3 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PENETRANTE_LOT3')));

          }

          field(75; "Total Salaire Net PONT_BIZERTE_LOT1 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PONT_BIZERTE_LOT1')));

          }

          field(76; "Total Salaire Net PORT FINA RAOUED RP2 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('PORT FINA RAOUED RP2')));

          }
          field(77; "Total Salaire Net RFR LOT1 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('RFR LOT1')));

          }

          field(78; "Total Salaire Net OUED_JOUMINE_MATEUR Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('OUED_JOUMINE_MATEUR')));

          }

          field(79; "Total Salaire Net MEDJERDA BOUSALEM Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('MEDJERDA BOUSALEM')));

          }

          field(80; "Total Salaire Net RVE719BOUSSADIA Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('RVE719BOUSSADIA')));

          }

          field(81; "Total Salaire Autres Affectation Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter(<> 'AUTOROUTE SBIKHA LO5' & <> 'CHANTIER_KEF_RR173' & <> 'BIZERTE_BASE_AERIEN' & <> 'PENETRANTE_LOT2' & <> 'PENETRANTE_LOT3' & <> 'PONT_BIZERTE_LOT1' & <> 'PORT FINA RAOUED RP2' & <> 'RFR LOT1' & <> 'OUED_JOUMINE_MATEUR' & <> 'MEDJERDA BOUSALEM' & <> 'RVE719BOUSSADIA' & <> 'DEPOT Z4' & <> 'ADMINISTRATION' & <> 'ADMINISTRATION_EXTEN')));

          }

          field(82; "Total Salaire DEPOT Z4 Hist"; Decimal)
          {

              FieldClass = FlowField;
              CalcFormula = sum("Rec. Salary Lines"."Net salary cashed" WHERE("No." = filter('PAI*'), Chantier = filter('DEPOT Z4')));

          }*/
        field(83; "Nbr Commande CHANTIER BOBO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Job No." = filter('CHANTIER-BOBO'))); //total
        }
        field(84; "Nbr Commande Parc Centrale"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Job No." = filter('PCENTRAL'))); //total
        }
        field(85; "Nbr Commande CARRIERE_NIGUI"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Job No." = filter('CARRIERE_NIGUI'))); //total
        }
        field(86; "Nbr Commande RN17/TKD-ORG"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Job No." = filter('RN17/TKD-ORG'))); //total
        }
        field(87; "Nbr Commande LOT 4 RN22"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" WHERE("Document Type" = filter(Order), "Job No." = filter('LOT 4 RN22'))); //total
        }
        field(88; "Last Month"; Option)
        {
            FieldClass = FlowFilter;
            Caption = 'Mois';
            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre,13ème,Congé,Prime,Rappel,Solder jour de congé';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","Congé",Prime,Rappel,"Solder jour de congé";
        }
        field(89; "Last Year"; Integer)
        {
            FieldClass = FlowFilter;
        }



    }
    keys
    {
        key(STG_Key1; "Cle Primaire")
        {
            Clustered = true;
        }
    }
    var
        myInt: Integer;

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}
