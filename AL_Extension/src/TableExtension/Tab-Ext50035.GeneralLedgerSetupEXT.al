TableExtension 50035 "General Ledger SetupEXT" extends "General Ledger Setup"
{
    fields
    {


        /*GL2024
       modify("Max. Payment Tolerance Amount")
       {
            Editable=true;
       }*/


        field(11315; "VAT Statement Template Name"; Code[10])
        {
            Caption = 'VAT Statement Template Name';
            Description = 'BE_TVA';
            TableRelation = "VAT Statement Template";
        }
        field(11316; "VAT Statement Name"; Code[10])
        {
            Caption = 'VAT Statement Name';
            Description = 'BE_TVA';
            TableRelation = if ("VAT Statement Template Name" = filter(<> '')) "VAT Statement Name".Name where("Statement Template Name" = field("VAT Statement Template Name"));

            trigger OnValidate()
            begin
                TestField("VAT Statement Template Name");
            end;
        }
        field(11317; "Use Workdate for Applying"; Boolean)
        {
            Caption = 'Use Workdate for Applying';
        }
        field(11318; "Jnl. Templ. Name for Applying"; Code[10])
        {
            Caption = 'Jnl. Templ. Name for Applying';
            TableRelation = "Gen. Journal Template";
        }
        field(11319; "Jnl. Batch Name for Applying"; Code[10])
        {
            Caption = 'Jnl. Batch Name for Applying';
            TableRelation = if ("Jnl. Templ. Name for Applying" = filter(<> '')) "Gen. Journal Batch".Name where("Journal Template Name" = field("Jnl. Templ. Name for Applying"));

            trigger OnValidate()
            begin
                TestField("Jnl. Templ. Name for Applying");
            end;
        }
        field(11320; "Simplified Intrastat Decl."; Boolean)
        {
            Caption = 'Simplified Intrastat Decl.';
            InitValue = true;
        }
        field(50000; "Souche Bureau Ordre"; Code[20])
        {
            Caption = 'Posted Invoice Nos.';
            Description = 'HJ DSFT 21-06-2012';
            TableRelation = "No. Series";
        }
        field(50001; "Chemin Bureau Ordre"; Text[250])
        {
        }
        field(50002; "Utilisateur Extra"; Code[20])
        {
            TableRelation = User;
        }
        field(50003; "Données Administration"; Text[250])
        {
        }
        field(50004; "Données Chantier"; Text[250])
        {
        }
        field(50005; "Erreur Administration"; Text[250])
        {
        }
        field(50006; "Erreur Chantier"; Text[250])
        {
        }
        field(50007; "Modèle Feuille Pull"; Text[250])
        {
            TableRelation = "Item Journal Template".Name;
        }
        field(50008; "Nom Feuille Pull"; Text[250])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Modèle Feuille Pull"));
        }
        field(50011; "Numero Affaire Interne"; Code[20])
        {
            TableRelation = Job;
        }
        field(50012; "Journal Template Echeance"; Code[10])
        {
            Caption = 'Jnl. Templ. Name for Applying';
            TableRelation = "Gen. Journal Template";
        }
        field(50013; "Journal Batch Echeance"; Code[10])
        {
            Caption = 'Journal Batch Echeance';
            TableRelation = if ("Journal Template Echeance" = filter(<> '')) "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Echeance"));

            trigger OnValidate()
            begin
                TestField("Journal Template Echeance");
            end;
        }
        field(50014; "Compte Credit"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50015; "Compte Charge Credit"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50016; "Compte Principal"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50017; "Compte Interet"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50018; "Type Reg. Caisse Ext"; Code[30])
        {
            TableRelation = "Payment Class";
        }
        field(50019; "Type Reg. Caisse Cpt"; Code[30])
        {
            TableRelation = "Payment Class";
        }
        field(50020; "Caisse EXT"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50021; "Caisse CPT"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50022; "Type Caisse CPT"; Code[20])
        {
            Description = 'HJ SORO 11-09-2014';
            TableRelation = "Payment Class";
        }
        field(50023; "Type Alim. Caisse"; Code[20])
        {
            Description = 'HJ SORO 11-09-2014';
            TableRelation = "Payment Class";
        }
        field(50024; "Souche Paiement En Lot"; Code[20])
        {
            Description = 'HJ SORO 22-12-2014';
            TableRelation = "No. Series";
        }
        field(50025; "Mode Regelement Paiement"; Code[20])
        {
            Description = 'HJ SORO 22-12-2014';
            TableRelation = "Payment Class";
        }
        field(50026; "Utiliser Update Code Nature"; Boolean)
        {
            Description = 'HJ SORO 16-02-2015';
        }
        field(50029; "Caisse CH1"; Code[20])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Bank Account";
        }
        field(50030; "Caisse CH2"; Code[20])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Bank Account";
        }
        field(50031; "BOR Caisse CHANTIER A"; Code[20])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Payment Class";
        }
        field(50032; "BOR Caisse CHANTIER B"; Code[20])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Payment Class";
        }
        field(50033; "BOR Caisse SIEGE A"; Code[20])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Payment Class";
        }
        field(50034; "BOR Caisse SIEGE B"; Code[20])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Payment Class";
        }
        field(50035; "Frais Fodec"; Code[20])
        {
            Description = '26-03-2015';
            TableRelation = "Item Charge";
        }
        field(50036; "Caisse Devise"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(50037; "Type Reg. Caisse Devise"; Code[30])
        {
            Description = 'HJ SORO 23-06-2014';
            TableRelation = "Payment Class";
        }
        //GL2025
        field(50042; "Migration"; DateTime)
        {

        }//
        field(60000; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 19-05-2015';
        }
        field(8001400; Localization; Option)
        {
            Caption = 'Localization';
            OptionCaption = 'Worldwide,France,Belgium,Swiss,Spain';
            OptionMembers = W1,FR,BE,CH,ES;

            trigger OnValidate()
            var
                tWarning: label 'Warning : Many rules depend to this option.\Do you confirm localisation update?';
            begin
                if Localization <> xRec.Localization then
                    if not Confirm(tWarning, false) then
                        Localization := xRec.Localization;
            end;
        }
        field(8003900; "Sales Unit-Amt Round. Prec."; Decimal)
        {
            Caption = 'Sales Unit-Amt Round. Prec.';
            DecimalPlaces = 0 : 9;
            Description = '5923';
            InitValue = 1;

            trigger OnValidate()
            begin
                Message(
                  Text022);
            end;
        }
        field(8004100; "Bank Waiting Period"; DateFormula)
        {
            Caption = 'Bank Waiting Period';
            InitValue = '-10D';
        }
        field(8004101; "Cash Hand. Reason Code"; Code[10])
        {
            Caption = 'Cash Handing-over Reason Code';
            TableRelation = "Reason Code";
        }
        field(8004102; "Discount Hand. Reason Code"; Code[10])
        {
            Caption = 'Discount Handing-over Reason Code';
            TableRelation = "Reason Code";
        }
        field(8004103; "Picture No."; Code[10])
        {
            Caption = 'Picture No.';
            TableRelation = "Header/Footer Logos"."No.";
        }
        field(8004104; "XML Seq. No. VAT Declaration"; Integer)
        {
            Caption = 'XML Seq. No. VAT Declaration';
            Description = 'Localisation BE';
        }
        field(8004111; "Check Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004111)));
            Caption = 'Check Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004112; "Bill Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004112)));
            Caption = 'Bill Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004113; "Transfer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004113)));
            Caption = 'Transfer Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004114; "Direct Debit Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004114)));
            Caption = 'Direct Debit Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004115; "Credit Card Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004115)));
            Caption = 'Credit Card Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004116; "VCOM Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004116)));
            Caption = 'VCOM Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004117; "Payment7 Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004117)));
            Caption = 'Payment7 Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004118; "Payment8 Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004118)));
            Caption = 'Payment8 Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004119; "Payment9 Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004119)));
            Caption = 'Payment9 Text';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004120; "Check Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004120)));
            Caption = 'Check Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004121; "Bill Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004121)));
            Caption = 'Bill Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004122; "Transfer Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004122)));
            Caption = 'Transfer Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004123; "Direct Debit Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004123)));
            Caption = 'Direct Debit Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004124; "Credit Card Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004124)));
            Caption = 'Credit Card Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004125; "VCOM Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004125)));
            Caption = 'VCOM Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004126; "Payment7 Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004126)));
            Caption = 'Payment7 Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004127; "Payment8 Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004127)));
            Caption = 'Payment8 Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004128; "Payment9 Footer Text"; Text[100])
        {
            CalcFormula = lookup(Translation2.Description where(TableID = const(98),
                                                                FieldID = const(8004128)));
            Caption = 'Payment9 Footer Text';
            Description = '#8865';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8004130; "Local Currency1"; Option)
        {
            Caption = 'Local Currency';
            OptionCaption = 'Euro,Other';
            OptionMembers = Euro,Other;

            trigger OnValidate()
            begin
                if "Local Currency" = "local currency"::Euro then
                    "Currency Euro" := '';
            end;
        }
        field(8004131; "Currency Euro1"; Code[10])
        {
            Caption = 'Currency Euro';
            TableRelation = Currency;

            trigger OnValidate()
            var
                ltNotAllowedForEuro: label 'It is not allowed to specify %1 when %2 is %3.';
            begin
                if ("Local Currency" = "local currency"::Euro) and ("Currency Euro" <> '') then
                    Error(
                      ltNotAllowedForEuro,
                      FieldCaption("Currency Euro"),
                      FieldCaption("Local Currency"),
                      "Local Currency");
            end;
        }
    }

    trigger OnModify()
    VAR
        lSingleInstance: Codeunit "Import SingleInstance2";
    BEGIN
        //PERF
        lSingleInstance.wSetGLAccount(Rec);
        //PERF//
    END;




    var
        JobLedgEntry: Record "Job Ledger Entry";
        //JobLedgEntry :Record 169;
        Text022: label 'You must close the program and start again in order to activate the unit-amount rounding feature.';
}

