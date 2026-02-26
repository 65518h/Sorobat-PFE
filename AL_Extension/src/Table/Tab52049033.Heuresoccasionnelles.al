
Table 52049033 "Heures occasionnelles"
{
    DrillDownPageID = "Heures Travail Occa.";
    //GL2024  ID dans Nav 2009 : "39001464"
    fields
    {
        field(1; "N° Salarié"; Code[20])
        {
            SQLDataType = Integer;
            Caption = 'N° Salarié';
            Description = '\\,Employee''s type=CONST(Hour based))';
            NotBlank = true;
            TableRelation = Employee."No." where(Status = const(Active));

            trigger OnValidate()
            begin
                Salarié.Get("N° Salarié");
                "Nom usuel" := Salarié."Last Name";
                Prénom := Salarié."First Name";

                "Code departement" := Salarié."Global Dimension 1 Code";
                "Code dossier" := Salarié."Global Dimension 2 Code";
                // direction := Salarié.Direction;
                service := Salarié.Service;
                section := Salarié.Section;
                HeuresSup.SetFilter("N° Salarié", Salarié."No.");
                if HeuresSup.Find('+') then
                    "N° Ligne" := HeuresSup."N° Ligne" + 1000
                else
                    "N° Ligne" := 1000;
            end;
        }
        field(2; "N° Ligne"; Integer)
        {
            Caption = 'N° Ligne';
        }
        field(3; "Nom usuel"; Text[50])
        {
            Caption = 'Nom usuel';
            Editable = false;
        }
        field(4; "Prénom"; Text[50])
        {
            Caption = 'Prénom';
            Editable = false;
        }
        field(7; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Mois de paiement" := Date2dmy(Date, 2) - 1;
                "Année de paiement" := Date2dmy(Date, 3);
            end;
        }
        field(10; "Code departement"; Code[20])
        {
            Caption = 'Code departement';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(11; "Code dossier"; Code[20])
        {
            Caption = 'Code dossier';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(15; "Heure debut"; Time)
        {

            trigger OnValidate()
            begin
                "Heure Fin" := 0T;
                "Nombre d'heures" := 0;
                "Nbre Jour" := 0;
            end;
        }
        field(16; "Heure Fin"; Time)
        {

            trigger OnValidate()
            var
                HeureDM: Time;
                HeureFM: Time;
                HeureDA: Time;
                HeureFA: Time;
                Nonworking: Boolean;
                Roul: Boolean;
                JourFree: Boolean;
                NbreHS: Decimal;
            begin
                calh.CalcHJour("N° Salarié", Date, HeureDM, HeureFM, HeureDA, HeureFA, Nonworking, Roul, JourFree);
                NbreHS := 0;
                //if
                if "Heure debut" > "Heure Fin" then
                    Validate("Nombre d'heures", ROUND((("Heure Fin" - 000000T) + (235959T - "Heure debut") + 1) / 3600000, 0.01))
                else
                    Validate("Nombre d'heures", ROUND(("Heure Fin" - "Heure debut") / 3600000, 0.01));
            end;
        }
        field(20; "Nombre d'heures"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Nombre d''heures';
            DecimalPlaces = 3 : 3;
            InitValue = 0;

            trigger OnValidate()
            begin
                /*MBY 12/01/2009 SAMI
                Employee.GET("N° Salarié");
                CLEAR(contratT);
                contratT.GET(Employee."Emplymt. Contract Code");
                CLEAR(Regim);
                Regim.GET(contratT."Regimes of work");
                IF "Nombre d'heures"<>0 THEN BEGIN
                   occaEnreg.RESET;
                   occaEnreg.SETCURRENTKEY("N° Salarié",Date,"Mois de paiement","Année de paiement");
                   occaEnreg.SETFILTER("N° Salarié","N° Salarié");
                   occaEnreg.SETRANGE(Date,Date);
                   occaEnreg.SETRANGE("Mois de paiement","Mois de paiement");
                   occaEnreg.SETRANGE("Année de paiement","Année de paiement");
                   IF occaEnreg.FIND('-') THEN
                        "Nbre Jour":=0
                    ELSE
                        "Nbre Jour":=1;
                 END;
                END MBY*/


                if contratT.Get("N° Salarié") then;
                if Regim.Get(contratT."Regimes of work") then;
                Salarié.Reset;
                Salarié.SetRange("No.", "N° Salarié");
                if Salarié.Find('-') then
                    //>>DSFT AGA 01/05/2010
                    case Salarié."Employee's type" of
                        0:
                            "Montant ligne" := Salarié."Basis salary" * "Nombre d'heures";
                        1:
                            "Montant ligne" := (Salarié."Basis salary" / Regim."Work Hours per month") * "Nombre d'heures";
                    end;
                //<<DSFT AGA 01/05/2010

            end;
        }
        field(21; "Tarif unitaire"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit tariff';
            Editable = false;
        }
        field(22; "Montant ligne"; Decimal)
        {
            AutoFormatType = 0;
            Caption = 'Line amount';
            DecimalPlaces = 3 : 3;
            Editable = false;
        }
        field(27; "Regime of work"; Code[10])
        {
            Caption = 'Regime of work';
            Editable = false;
            TableRelation = "Regimes of work";
        }
        field(30; "Same week worked hour"; Decimal)
        {
            CalcFormula = sum("Heures occa. enreg. m"."Nombre d'heures" where("N° Salarié" = field("N° Salarié"),
                                                                               Semaine = field(Semaine),
                                                                               "Année de paiement" = field("Année de paiement")));
            Caption = 'Same week worked hour';
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Overcharge line"; Integer)
        {
            Caption = 'Overcharge line';
            Editable = false;
            TableRelation = "Bon Reglement".Annee where("N° Bon" = field("Regime of work"));
        }
        field(32; "Overcharge target line"; Integer)
        {
            Caption = 'Overcharge target line';
            Editable = false;
            TableRelation = "Bon Reglement".Annee where("N° Bon" = field("Regime of work"));
        }
        field(70; "Type Jours"; Option)
        {
            OptionMembers = Normal,"Chômé Payé","Chômé Non Payé",Nuit,"jour Repos";
        }
        field(80; "Nbre Jour"; Decimal)
        {

            trigger OnValidate()
            begin
                //MBY 12/01/2009 SAMI
                Employee.Get("N° Salarié");
                Clear(contratT);
                contratT.Get(Employee."Emplymt. Contract Code");
                Clear(Regim);
                Regim.Get(contratT."Regimes of work");
                if Regim."Worked Day Per Month" > 0 then begin
                    "Montant ligne" := Employee."Basis salary" * "Nbre Jour" / Regim."Worked Day Per Month";
                end;
                //END MBY
            end;
        }
        field(100; "Filtre date"; Date)
        {
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(101; "Heures Enregistrées"; Decimal)
        {
            CalcFormula = sum("Heures occa. enreg. m"."Nombre d'heures" where("N° Salarié" = field("N° Salarié"),
                                                                               "Année de paiement" = field("Année de paiement"),
                                                                               "Mois de paiement" = field("Mois de paiement")));
            FieldClass = FlowField;
        }
        field(300; "Paiement No."; Code[20])
        {
        }
        field(601; "Heures Sup Enregistrées"; Decimal)
        {
            CalcFormula = sum("Heures sup. eregistrées m"."Nombre d'heures" where("N° Salarié" = field("N° Salarié"),
                                                                                      Date = field("Filtre date"),
                                                                                      "Type Jours" = const(Normal),
                                                                                      "Type heure" = filter("Heure Sup.")));
            FieldClass = FlowField;
        }
        field(50001; "Nombre Jours Prime Panier"; Decimal)
        {
        }
        field(50003; "Taux de majoration"; Decimal)
        {
            Editable = false;
        }
        field(50010; "Mois de paiement"; Option)
        {
            Caption = 'Mois de paiement';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December,13rd,14th,Other';
            OptionMembers = Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre","13ème","14ème",Autre;

            trigger OnValidate()
            begin
                verifmoispaie;
            end;
        }
        field(50011; "Année de paiement"; Integer)
        {
            Caption = 'Année de paiement';

            trigger OnValidate()
            begin
                verifmoispaie;
            end;
        }
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
        /*   field(50018; "Jours Supp Calculé"; Decimal)
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
        key(Key1; "N° Salarié", "N° Ligne", "Code departement", "Code dossier")
        {
            Clustered = true;
            SumIndexFields = "Montant ligne", "Nombre d'heures";
        }
        key(Key2; "N° Ligne")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Salarié": Record Employee;
        "PériodeCompta": Record "Accounting Period";
        HeuresSup: Record "Heures occasionnelles";
        Employee: Record Employee;
        contratT: Record "Employment Contract";
        Regim: Record "Regimes of work";
        occaEnreg: Record "Heures occa. enreg. m";
        calh: Codeunit "Management of absences";


    procedure verifmoispaie()
    var
        Paieenreg: Record "Rec. Salary Headers";
    begin
        /*Paieenreg.RESET;
        Paieenreg.SETRANGE(Month,"Mois de paiement");
        Paieenreg.SETRANGE(Year,"Année de paiement");
        IF Paieenreg.FIND('-') THEN
          ERROR(' Mois Déjà Clôturer  !!!!!! ');*/

    end;
}

