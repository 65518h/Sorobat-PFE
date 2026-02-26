Table 8004066 "Dynalog - Composants (BXmx)"
{
    // //MULTI-DEVIS GESWAY 16/10/02 Interface Multi-Devis Express


    fields
    {
        field(1; Type; Integer)
        {
            Description = 'Definit si Matériaux, Mo, SST';
        }
        field(2; "Code"; Code[18])
        {
        }
        field(3; Designation; Text[250])
        {
            Description = 'Libellé de l''article';
        }
        field(4; Complement; Text[80])
        {
            Description = 'Libellé optionnel';
        }
        field(5; "Libelle Commercial"; Text[250])
        {
        }
        field(6; "Libelle Technique"; Text[250])
        {
        }
        field(7; Unite; Code[10])
        {
        }
        field(8; "Prix tarif"; Decimal)
        {
        }
        field(9; Remise; Decimal)
        {
        }
        field(10; PAUHF; Decimal)
        {
            Description = 'Prix d''Achat Unitaire Hors Fournitures';
        }
        field(11; PAU; Decimal)
        {
            Description = 'Prix d''Achat Unitaire';
        }
        field(12; FG; Decimal)
        {
            Description = 'Coefficient de Frais Généraux';
        }
        field(13; PRU; Decimal)
        {
            Description = 'Prix de Revient Unitaire';
        }
        field(14; Benefice; Decimal)
        {
            Description = 'Coefficient de Bénéfice';
        }
        field(15; PVU; Decimal)
        {
            Description = 'Prix de Vente Unitaire';
        }
        field(16; "Coef de perte"; Decimal)
        {
        }
        field(17; Cadence; Decimal)
        {
        }
        field(18; TVA; Decimal)
        {
            Description = 'Code TVA';
        }
        field(19; "Date MAJ"; Text[20])
        {
            Description = 'Dernière date de modification';
        }
        field(20; "Mot clef"; Text[25])
        {
            Description = 'Permet à l''utilisateur de faciliter les recherches';
        }
        field(21; Famille; Code[18])
        {
        }
        field(22; IdFHier; Text[21])
        {
            Description = 'Définit la position dans le hiérarchie de la famille';
        }
        field(23; Fournisseur; Code[15])
        {
        }
        field(24; "Date d'effet"; Date)
        {
            Description = 'Date d''effet des prix';
        }
        field(25; Graphique; Text[250])
        {
            Description = 'Non utilisé';
        }
        field(26; "Graphique (chemin)"; Text[250])
        {
            Description = 'Non utilisé';
        }
        field(27; "Code barre"; Text[20])
        {
        }
        field(28; "Code regroupement"; Text[15])
        {
            Description = 'Non utilisé';
        }
        field(29; "Code substitution"; Code[18])
        {
            Description = 'Indique un code de substitution en cas de manque';
        }
        field(30; "CarTech Code 1"; Text[5])
        {
            Description = 'Permet en trois caractéristiques de définir un produit pour faciliter les recherches';
        }
        field(31; "CarTech Qte 1"; Decimal)
        {
        }
        field(32; "CarTech Code 2"; Text[5])
        {
        }
        field(33; "CarTech Qte 2"; Decimal)
        {
        }
        field(34; "CarTech Code 3"; Text[5])
        {
        }
        field(35; "CarTech Qte 3"; Decimal)
        {
        }
        field(36; PoseCheck; Boolean)
        {
            Description = 'Indicateur d''utilisation de pose dans le matériau';
        }
        field(37; RemiseRadio; Integer)
        {
            Description = 'Indique si Remise ou Tarif fixe';
        }
        field(38; PVURadio; Integer)
        {
            Description = 'Indique si PVU fixe ou Coefficient de bénéfice';
        }
        field(39; PVUPRadio; Integer)
        {
            Description = 'Indique si PVU produit posé fixe ou Coefficient matériau';
        }
        field(40; TypeMO; Integer)
        {
            Description = 'Type de MO';
        }
        field(41; CodeMO; Code[18])
        {
            Description = 'Code de MO';
        }
        field(42; QteMO; Decimal)
        {
            Description = 'Qté de MO';
        }
        field(43; FGMO; Decimal)
        {
            Description = 'Coef. de F.G. appliqué sur la MO';
        }
        field(44; BenefMO; Decimal)
        {
            Description = 'Coef. de Bénéfice appliqué sur la MO';
        }
        field(45; PVUMO; Decimal)
        {
            Description = 'PVU de MO';
        }
        field(46; SupprimeCheck; Boolean)
        {
            Description = 'Indique si le produit existe encore';
        }
        field(47; SommeilCheck; Boolean)
        {
            Description = 'Indique si le produit doit apparaître dans l''explorateur bibliothèque';
        }
        field(48; PauFrnt; Decimal)
        {
            Description = 'PAU des petites fournitures';
        }
        field(49; CentFrnt; Decimal)
        {
            Description = 'Pourcentage de Petites fournitures par rapport au PAUHF';
        }
        field(50; FrntRadio; Integer)
        {
            Description = 'Indique si Pourcentage ou valeur de petites fournitures doit être bloqué';
        }
        field(51; FrntCheck; Boolean)
        {
            Description = 'Indique si l''on utilise ou non les petites fournitures';
        }
        field(52; "Code comptable"; Code[15])
        {
            Description = 'Code Comptabilité générale';
        }
        field(53; Analytique1; Code[15])
        {
            Description = 'Code Compta Analytique';
        }
        field(54; Analytique2; Code[15])
        {
            Description = 'Code Compta Analytique2';
        }
        field(55; Analytique3; Code[15])
        {
            Description = 'Code Compta Analytique';
        }
        field(56; AnalytiqueRadio; Integer)
        {
            Description = 'Numéro du code analytique utilisé';
        }
        field(57; UCCarTech1; Text[5])
        {
            Description = 'Définit 5 unités de convertion Définit une caractéristiques technique (M2, KG, ...)';
        }
        field(58; UCUnite1; Text[3])
        {
            Description = 'Unité de convertion';
        }
        field(59; UCVal1; Decimal)
        {
            Description = 'Valeur de l''unité de convertion par rapport à celle du matériau';
        }
        field(60; UCCarTech2; Text[5])
        {
        }
        field(61; UCUnite2; Text[3])
        {
        }
        field(62; UCVal2; Decimal)
        {
        }
        field(63; UCCarTech3; Text[5])
        {
        }
        field(64; UCUnite3; Text[3])
        {
        }
        field(65; UCVal3; Decimal)
        {
        }
        field(66; UCCarTech4; Text[5])
        {
        }
        field(67; UCUnite4; Text[3])
        {
        }
        field(68; UCVal4; Decimal)
        {
        }
        field(69; UCCarTech5; Text[5])
        {
        }
        field(70; UCUnite5; Text[3])
        {
        }
        field(71; UCVal5; Decimal)
        {
        }
        field(72; Fournisseur1; Code[15])
        {
            Description = 'Code Fournisseurs et codes articles principaux';
        }
        field(73; CodeArticleFr1; Code[18])
        {
        }
        field(74; Fournisseur2; Code[15])
        {
        }
        field(75; CodeArticleFr2; Code[18])
        {
        }
        field(76; Fournisseur3; Code[15])
        {
        }
        field(77; CodeArticleFr3; Code[18])
        {
        }
        field(78; Metre; Text[250])
        {
        }
        field(79; CAOKey; Integer)
        {
        }
        field(80; CAOBin; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

