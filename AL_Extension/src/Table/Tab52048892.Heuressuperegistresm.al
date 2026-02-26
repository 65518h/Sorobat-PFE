Table 52048892 "Heures sup. eregistrées m"
{//GL2024  ID dans Nav 2009 : "39001417"
    DrillDownPageID = "Heures sup. enregistrées";
    LookupPageID = "Heures sup. enregistrées";

    fields
    {
        field(1; "N° Salarié"; Code[20])
        {
            Caption = 'Emplyee No.';
            TableRelation = Employee."No.";
        }
        field(2; "N° Ligne"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Nom usuel"; Text[60])
        {
            Caption = 'Last Name';
        }
        field(4; "Prénom"; Text[60])
        {
            Caption = 'Last Name';
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;
        }
        field(10; "Code departement"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; "Code dossier"; Code[20])
        {
            Caption = 'Project Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Heure debut"; Time)
        {
        }
        field(16; "Heure Fin"; Time)
        {
        }
        field(20; "Nombre d'heures"; Decimal)
        {
            Caption = 'Nombre d''heures';
        }
        field(21; "Tarif unitaire"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit tariff';
        }
        field(22; "Montant Ligne"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Line amount';
            DecimalPlaces = 3 : 3;
            Editable = true;
        }
        field(40; "Date comptabilisation"; Date)
        {
            Caption = 'Posting Date';
        }
        field(50; "N° transaction"; Integer)
        {
            Caption = 'N° transaction';
        }
        field(60; "Mois de paiement"; Option)
        {
            Caption = 'Payment month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Prime,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Prime,Autre,"Congé";
        }
        field(61; "Année de paiement"; Integer)
        {
            Caption = 'Payment year';
        }
        field(70; "Type Jours"; Option)
        {
            OptionMembers = Normal,"Chômé Payé","Chômé Non Payé",Nuit,"jour Repos";
        }
        field(80; "Employee Posting Group"; Code[20])
        {
            Caption = 'Groupe Compta. Salariée';
        }
        field(200; "Système"; Boolean)
        {
        }
        field(300; "Paiement No."; Code[20])
        {
        }
        field(50000; "Taux de majoration"; Decimal)
        {
        }
        /* field(50001; Affectation; Code[20])
         {
         }
         field(50002; Qualification; Code[20])
         {
         }
         field(50003; "Heure Normal"; Decimal)
         {
         }
         field(50004; "Nombre Jours Supp"; Decimal)
         {
         }
         field(50005; "Montant Jours Supp"; Decimal)
         {
         }
         field(50006; Prime; Decimal)
         {
         }*/
        field(50012; Semaine; Integer)
        {
        }
        /* field(50013; "Nombre Jours Conge Annuelle"; Decimal)
         {
         }
         field(50014; "Nombre Jours Conge Excep"; Decimal)
         {
         }
         field(50015; "Nombre Jours Ferié"; Decimal)
         {
         }*/
        field(50020; direction; Code[10])
        {
        }
        field(50021; service; Code[10])
        {
        }
        field(50022; section; Code[10])
        {
        }
        field(39001450; "Type heure"; Option)
        {
            OptionMembers = "Heure Sup.",Roulement;
        }
        field(39001451; "Employee Statistic Group"; Code[30])
        {
            Caption = 'Employee Posting Group';
            Editable = true;
            TableRelation = "Employee Statistics Group";
        }
        field(39001460; "N° Ligne Travailler"; Integer)
        {
        }
        field(39001461; "N° Transaction Travailler"; Integer)
        {
        }
        field(39001490; Quinzaine; Option)
        {
            Description = 'AGA DSFT 02-05-2011';
            OptionCaption = '1er,2ème,Autre';
            OptionMembers = "1er","2ème",Autre;
        }
    }

    keys
    {
        key(Key1; "N° transaction", "N° Ligne", "N° Salarié")
        {
            Clustered = true;
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key2; "N° Salarié", "Code departement", "Code dossier", Date, "Type Jours")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key3; "N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.")
        {
            SumIndexFields = "Montant ligne", "Nombre d'heures";
        }
        key(Key4; "Taux de majoration")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key5; "N° Salarié")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key6; "N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement", Quinzaine)
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key7; "N° Salarié", "Mois de paiement", "Année de paiement", "Type heure")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key8; "N° Salarié", Date, "Type Jours", "Type heure", "Code departement", "Code dossier")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key9; "Paiement No.", "Employee Posting Group", "N° transaction", "N° Salarié")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key10; "Paiement No.", "Employee Posting Group", "Code departement", "Code dossier", "N° Salarié")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key11; "Année de paiement", "Mois de paiement", "Paiement No.")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key12; "Année de paiement", "Mois de paiement", "Paiement No.", "Code departement", "Code dossier", "Employee Posting Group")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key13; "N° Salarié", Date, "Type Jours", "Taux de majoration")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key14; "N° Salarié", "Mois de paiement", Date, "Type Jours")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key15; "N° Salarié", "Mois de paiement", Date, "Type Jours", "Taux de majoration")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key16; "Année de paiement", "Mois de paiement", "Date comptabilisation", "N° Salarié")
        {
        }
        key(Key17; "Employee Statistic Group", "Année de paiement", "Mois de paiement", "Paiement No.")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key18; "N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine)
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne";
        }
        key(Key19; "N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.", "Type Jours")
        {
            SumIndexFields = "Montant ligne", "Nombre d'heures";
        }
        key(Key20; "N° Salarié", "Mois de paiement", "Année de paiement", Date, "Paiement No.", "Type Jours", "Taux de majoration")
        {
            SumIndexFields = "Montant ligne", "Nombre d'heures";
        }
    }

    fieldgroups
    {
    }
}

