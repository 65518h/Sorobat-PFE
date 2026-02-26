table 52049022 "Ligne frais de mission"
{ //GL2024  ID dans Nav 2009 : "39001500"
  //GL2024  DrillDownPageID = 70149;
  //GL2024 LookupPageID = 70149;

    fields
    {
        field(1; "N°"; Code[20])
        {
        }
        field(2; "N° Ligne"; Integer)
        {
        }
        field(3; "N° Salarier"; Code[20])
        {
            TableRelation = "Equipe mission"."Employee No." WHERE("N° Demande" = FIELD("N°"));

            trigger OnValidate()
            var
                RecLOrdreMission: Record "Entete frais mission";
                RecLSalarier: Record 5200;
                RecLEnveloppeBank: Record "Enveloppe Bank";
            begin
                IF RecLOrdreMission.GET("N°") THEN BEGIN
                    Destination := RecLOrdreMission.Destination;
                    "Groupe destination" := RecLOrdreMission."Groupe destination";
                    "Moyen transport" := RecLOrdreMission."Moyen transport";
                    Quantite := RecLOrdreMission."Date fin" - RecLOrdreMission."Date debut" + 1;
                    "Montant DS" := Quantite * "Prix Unitaire";
                    "Enveloppe Bank" := RecLOrdreMission."Enveloppe Bank";
                    //RecLEnveloppeBank.GET("Enveloppe Bank");
                    //VerifierBudgetFrais;
                    "Code Bank" := RecLEnveloppeBank."Code bank";
                END;
                IF RecLSalarier.GET("N° Salarier") THEN BEGIN
                    "Global Dimension 1" := RecLSalarier."Global Dimension 1 Code";
                    "Global Dimension 2" := RecLSalarier."Global Dimension 2 Code";
                END;
            end;
        }
        field(4; "Code Frais mission"; Code[20])
        {
            TableRelation = "Bareme des frais de mission" WHERE("Moyen Transport" = FIELD("Moyen transport"),
                                                                "Groupe Destination" = FIELD("Groupe destination"));

            trigger OnValidate()
            var
                RecLBaremeFrais: Record "Bareme des frais de mission";
            begin
                IF RecLBaremeFrais.GET("Code Frais mission", "Groupe destination", "Moyen transport") THEN BEGIN
                    //Designation:=RecLBaremeFrais.Designation;
                    "Prix Unitaire" := RecLBaremeFrais."Montant DS";
                    "Montant DS" := Quantite * "Prix Unitaire";
                    VerifierEnvellopeBank;
                    VerifierBudgetFrais;
                    "G/L Account" := RecLBaremeFrais."G/L Account";
                    "Bal. G/L Account" := RecLBaremeFrais."Bal. G/L Account";
                    Designation := RecLBaremeFrais.Designation;
                END;
            end;
        }
        field(5; Designation; Text[50])
        {
        }
        field(6; Quantite; Decimal)
        {

            trigger OnValidate()
            begin
                "Montant DS" := Quantite * "Prix Unitaire";
                VerifierEnvellopeBank;
            end;
        }
        field(7; "Prix Unitaire"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                "Montant DS" := Quantite * "Prix Unitaire";
                VerifierEnvellopeBank;
                VerifierBudgetFrais;
            end;
        }
        field(8; "Montant DS"; Decimal)
        {
            AutoFormatType = 1;

            trigger OnValidate()
            begin
                "Montant DS" := Quantite * "Prix Unitaire";
                "Montant a comptabiliser" := Quantite * "Prix Unitaire";
                VerifierEnvellopeBank;
                VerifierBudgetFrais;
            end;
        }
        field(9; Destination; Code[10])
        {
            TableRelation = "Liste des destinations";
        }
        field(10; "Groupe destination"; Code[20])
        {
            TableRelation = "Liste des destinations";
        }
        field(11; "Moyen transport"; Code[20])
        {
            TableRelation = "Liste Moyens de transport";
        }
        field(13; "Global Dimension 1"; Code[20])
        {
            Caption = 'Code département';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2"; Code[20])
        {
            Caption = 'Code dossier';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Montant a comptabiliser"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Montant à comptabiliser';
        }
        field(100; "G/L Account"; Code[20])
        {
            Caption = 'N° Compte';
            TableRelation = "G/L Account";
        }
        field(101; "Bal. G/L Account"; Code[20])
        {
            Caption = 'N° Compte contrepartie';
            TableRelation = "G/L Account";
        }
        field(200; "Code Bank"; Code[20])
        {
            TableRelation = "Bank Account" WHERE("Currency Code" = FILTER(''));
        }
        field(201; "Enveloppe Bank"; Code[20])
        {
            TableRelation = "Enveloppe Bank" WHERE("Code bank" = FIELD("Code Bank"));
        }
    }

    keys
    {
        key(Key1; "N°", "N° Ligne")
        {
            Clustered = true;
        }
        key(Key2; "Enveloppe Bank")
        {
            SumIndexFields = "Montant DS";
        }
    }

    fieldgroups
    {
    }


    procedure GetBankPostingAccount(CodLBank: Code[20]): Code[20]
    var
        RecLBankAccountPostGroup: Record 277;
        RecLBankAccount: Record 270;
    begin
        RecLBankAccount.GET(CodLBank);
        RecLBankAccount.TESTFIELD("Bank Acc. Posting Group");
        RecLBankAccountPostGroup.GET(RecLBankAccount."Bank Acc. Posting Group");
        //GL2024 EXIT(RecLBankAccountPostGroup."G/L Bank Account No.");
    end;


    procedure VerifierEnvellopeBank(): Boolean
    var
        RecLEnvellopeBank: Record "Enveloppe Bank";
    begin
        IF RecLEnvellopeBank.GET("Enveloppe Bank") THEN BEGIN
            RecLEnvellopeBank.CALCFIELDS(RecLEnvellopeBank."Montant ammorti");
            IF (RecLEnvellopeBank."Montant ammorti" + "Montant DS") > RecLEnvellopeBank."Montant DS" THEN
                ERROR('Votre enveloppe banque ne vous permet pas d''ajouter ce montant!');
        END;
    end;


    procedure VerifierBudgetFrais()
    var
        RecLFrais: Record 5800;
        RecLOrdreMission: Record "Entete frais mission";
        Test: Decimal;
        RecLUser: Record User;
    begin
        /*RecLOrdreMission.GET("N°");
        RecLFrais.GET("Code Frais mission");
        RecLFrais.SETFILTER(RecLFrais."Filtre budget",RecLOrdreMission."Item Budget Name");
        RecLFrais.SETFILTER(RecLFrais."Date Filter",'%1..%2',DMY2DATE(01,DATE2DMY(RecLOrdreMission."Date debut",2),
                                                                         DATE2DMY(RecLOrdreMission."Date debut",3)),
                                                            CALCDATE('FM',DMY2DATE(01,DATE2DMY(RecLOrdreMission."Date debut",2),
                                                                         DATE2DMY(RecLOrdreMission."Date debut",3))));
        RecLFrais.CALCFIELDS(RecLFrais."Depense  Budgetisee DS Mois N",
                   RecLFrais."Montant Frais MG Facturé",RecLFrais."Montant Frais MG Avoir");
        Test:=RecLFrais."Depense  Budgetisee DS Mois N"
               -RecLFrais."Montant Frais MG Facturé"
               +RecLFrais."Montant Frais MG Avoir"
               -"Montant DS";
        RecLUser.GET(USERID);
        IF Test<0 THEN
          IF RecLUser."Forçage budget frais mission" THEN
          BEGIN
            IF NOT CONFIRM('Vous risquer de dépasser le montant budgetisé, Voulez-vous continuer?',FALSE) THEN
            BEGIN
              ERROR('Ligne frais interrompue, risque de dépassement du budget!');
            END;
          END
          ELSE
          BEGIN
            ERROR('Ligne frais interrompue, risque de dépassement du budget!');
          END;
        MBY*/

    end;
}

