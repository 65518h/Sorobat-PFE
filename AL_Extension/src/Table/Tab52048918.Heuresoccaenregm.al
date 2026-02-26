Table 52048918 "Heures occa. enreg. m"
{//GL2024  ID dans Nav 2009 : "39001465"
    DrillDownPageID = "Heures trav. enregistrées";
    LookupPageID = "Heures trav. enregistrées";

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
        field(3; "Nom usuel"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(4; "Prénom"; Text[50])
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
            Caption = 'Hours Number';
        }
        field(21; "Tarif unitaire"; Decimal)
        {
            Caption = 'Unit tariff';
        }
        field(22; "Montant ligne"; Decimal)
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
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;
        }
        field(61; "Année de paiement"; Integer)
        {
            Caption = 'Payment year';
        }
        field(70; "Type Jours"; Option)
        {
            OptionMembers = Normal,"Chômé Payé","Chômé Non Payé",Nuit,"jour Repos";
        }
        field(80; "Nbre Jour"; Decimal)
        {
        }
        field(100; "Filtre Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(300; "Paiement No."; Code[20])
        {
        }
        field(50000; "Taux de majoration"; Decimal)
        {
        }
        field(50001; "Nombre Jours Prime Panier"; decimal)
        {
        }
        /*  field(50002; Qualification; Code[20])
          {
          }
          field(50004; "Jours Deplacement"; Decimal)
          {
          }*/
        field(50012; Semaine; Integer)
        {
        }
        field(50013; direction; Code[10])
        {
        }
        field(50014; service; Code[10])
        {
        }
        field(50015; section; Code[10])
        {
        }
        field(50016; "Jour indemnité"; Decimal)
        {
        }
        /* field(50018; "Jours Supp Calculé"; Decimal)
         {
             Editable = false;
         }
         field(50019; "Heure Supp Calculé"; Decimal)
         {
             Editable = false;
         }
         field(50020; "Heure Travaillé"; Decimal)
         {
         }
         field(50021; "Jours Travaillé"; Decimal)
         {
         }
         field(50022; Rappel; Decimal)
         {
         }
         field(50023; Retenu; Decimal)
         {
         }
         field(50024; Cession; Decimal)
         {
         }
         field(50030; Kmetrage; Decimal)
         {
             Description = 'RB SORO 06/02/2016';
         }
         field(50031; "Congé Spéciale"; Decimal)
         {
             Description = 'MH SORO 03-10-2023';
         }
         field(50032; "Congé"; Decimal)
         {
             Description = 'MH SORO 03-10-2023';
         }
         field(50033; "Férier"; Decimal)
         {
             Description = 'MH SORO 03-10-2023';
         }
         field(50034; "Description Qualification"; Text[150])
         {
             Description = 'MH SORO 03-10-2023';
         }
         field(50039; "Nbre Jours Absence"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(50040; "Nbre Jours Sanction"; Decimal)
         {
             Description = 'MH SORO 22-04-2024';
         }
         field(50041; "Motif Sanction"; Text[150])
         {
             Description = 'MH SORO 22-04-2024';
         }*/
        field(39001490; Quinzaine; Option)
        {
            OptionCaption = '1er,2ème,Autre';
            OptionMembers = "1er","2ème",Autre;
        }
        field(39001491; "Productivité"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "N° transaction", "N° Ligne", "N° Salarié")
        {
            Clustered = true;
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key2; "N° Salarié", "Code departement", "Code dossier", Date, "Type Jours")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key3; "N° Salarié", "Mois de paiement", "Année de paiement", "Paiement No.")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key4; "Taux de majoration")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key5; "N° Salarié", Date, "Mois de paiement", "Année de paiement", "Paiement No.", Semaine)
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key6; "N° Salarié")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key7; "Mois de paiement", "Année de paiement", "Date comptabilisation", "N° Salarié")
        {
        }
        key(Key8; "N° Salarié", "Taux de majoration", "Mois de paiement", "Année de paiement")
        {
        }
        key(Key9; "N° Salarié", Date, "Paiement No.")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key10; "N° Salarié", "Mois de paiement", "Année de paiement", Quinzaine, "Paiement No.")
        {
            SumIndexFields = "Nombre d'heures", "Montant ligne", "Nbre Jour";
        }
        key(Key11; section, "Mois de paiement", "Année de paiement")
        {
        }

        /*  key(Key13; Qualification)
          {
          }*/
    }

    fieldgroups
    {
    }
}

