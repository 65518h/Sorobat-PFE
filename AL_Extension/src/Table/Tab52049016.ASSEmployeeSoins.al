
Table 52049016 "ASS-Employee Soins"
{
    //GL2024  ID dans Nav 2009 : "39001493"
    fields
    {
        field(1; Matricule; Code[20])
        {
            Caption = 'Matricule';
            NotBlank = true;
            TableRelation = Employee."No." where("No." = field(Matricule));

            trigger OnValidate()
            begin
                RecGEmployee.SetRange(RecGEmployee."No.", Matricule);
                if RecGEmployee.FindFirst then
                    NomAdherant := RecGEmployee."First Name" + ' ' + RecGEmployee."Last Name";
            end;
        }
        field(2; NomAdherant; Text[30])
        {
            Caption = 'NomAdherant';
            Editable = false;

            trigger OnValidate()
            begin
                NomAdherant := UpperCase(NomAdherant);
            end;
        }
        field(3; DateVisite; Date)
        {
            Caption = 'Date Visite';
        }
        field(4; Medecin; Text[30])
        {
            Caption = 'Medecin';
            TableRelation = "ASS-Medecin".Nom WHERE(Nom = FIELD(Medecin));

            trigger OnValidate()
            begin

                RecGMedecin.SETRANGE(RecGMedecin.Nom, Medecin);
                IF RecGMedecin.FINDFIRST AND RecGMedecin."Type medcin" = TRUE THEN
                    PrixMedecin := RecGMedecin.Prix;
                IF RecGMedecin.FINDFIRST AND RecGMedecin."Type medcin" = FALSE THEN
                    PrixBiologiste := RecGMedecin.Prix;
                //MESSAGE('%1',Medecin);
                //MESSAGE('%1',RecGMedecin.Nom);
                //MESSAGE('%1',RecGMedecin.Prix);
            end;
        }
        field(5; PrixMedecin; Decimal)
        {
            Caption = 'Montant Consultation';
            DecimalPlaces = 3 : 3;
        }
        field(6; PrixPharmacie; Decimal)
        {
            Caption = 'Pharmacie';
            DecimalPlaces = 3 : 3;
        }
        field(7; PrixInjectionPharmacie; Decimal)
        {
            Caption = 'Injection Pharmacie';
            DecimalPlaces = 3 : 3;
        }
        field(8; Biologiste; Text[30])
        {
            TableRelation = "ASS-Medecin".Nom WHERE(Nom = FIELD(Biologiste));

            trigger OnValidate()
            begin
                RecGMedecin.SETRANGE(RecGMedecin.Nom, Biologiste);
                IF RecGMedecin.FINDFIRST THEN
                    PrixBiologiste := RecGMedecin.Prix;
            end;
        }
        field(9; PrixBiologiste; Decimal)
        {
            Caption = 'Analyse';
            DecimalPlaces = 3 : 3;
        }
        field(10; PrixOptique; Decimal)
        {
            Caption = 'Optique';
            DecimalPlaces = 3 : 3;
        }
        field(11; "PrixClinique/Hopital"; Decimal)
        {
            Caption = 'Clinique/Hopital';
            DecimalPlaces = 3 : 3;
        }
        field(12; "PrixInjectionClinique/Hopital"; Decimal)
        {
            Caption = 'Injection Clinique/Hopital';
            DecimalPlaces = 3 : 3;
        }
        field(13; PrixSoinsDentaires; Decimal)
        {
            Caption = 'SoinsDentaires';
            DecimalPlaces = 3 : 3;
        }
        field(14; PrixRadio; Decimal)
        {
            Caption = 'Radio';
            DecimalPlaces = 3 : 3;
        }
        field(15; PrixVignette; Decimal)
        {
            Caption = 'Vignette';
            DecimalPlaces = 3 : 3;
        }
        field(16; Rembourse; Boolean)
        {
            Caption = 'Rembourse';
        }
        field(17; MontantRembourse; Decimal)
        {
            Caption = 'MontantRembourse';
            DecimalPlaces = 3 : 3;
        }
        field(19; "No."; Code[20])
        {
            TableRelation = "Entete BRD"."No. BRD";
        }
        field(20; "Line No."; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
        key(Key2; Matricule, DateVisite)
        {
            Clustered = true;
        }
        key(Key3; Medecin)
        {
        }
        key(Key4; Biologiste, PrixBiologiste)
        {
        }
        key(Key5; PrixMedecin)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        /*IF "No." = '' THEN BEGIN
          SalesSetup.GET;
          SalesSetup.TESTFIELD("Customer Nos.");
          NoSeriesMgt.InitSeries(SalesSetup."Customer Nos.",xRec."No. Series",0D,"No.","No. Series");
        END;
        IF "No." = '' THEN BEGIN
          HumanRessourceSetup.GET;
          HumanRessourceSetup.TESTFIELD("N° Borderau");
          NoSeriesMgt.InitSeries(HumanRessourceSetup."N° Borderau",'',0D,"No.","No. Series");
        END;*/

    end;

    trigger OnModify()
    var
        RecLBrdHeader: Record "Entete BRD";
    begin
        RecLBrdHeader.Get("No.");
        RecLBrdHeader.DateLastModif := TODAY;
        RecLBrdHeader.Modify;
    end;

    var
        RecGMedecin: Record "ASS-Medecin";
        RecGEmployee: Record Employee;
        NoSeriesMgt: Codeunit 396;
        HumanRessourceSetup: Record "Human Resources Setup";
}

