TableExtension 50207 "Payment Line ArchiveEXT" extends "Payment Line Archive"
{
    fields
    {


        field(50000; "External Invoice No."; Code[20])
        {
            Caption = 'External Invoice No.';
            Description = 'SDT V1.00';
        }
        field(50001; "Libellé"; Text[80])
        {
            Description = 'SDT V1.00';
            Editable = true;
            TableRelation = if ("Account Type" = filter(Customer)) Customer.Name where("No." = field("Account No."))
            else
            if ("Account Type" = filter(Vendor)) Vendor.Name where("No." = field("Account No."));
        }
        field(50002; Exported; Boolean)
        {
            Caption = 'Exportée';
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50003; "Communication XRT"; Boolean)
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50004; "En Banque"; Boolean)
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50005; Annulation; Boolean)
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50006; "Type paiement"; Option)
        {
            Description = 'SDT V1.00';
            OptionCaption = 'Paiement,Avance';
            OptionMembers = Paiement,Avance;
        }
        field(50007; "N° commande"; Code[20])
        {
            Description = 'SDT V1.00';
        }
        field(50008; "Code Retenue à la Source"; Code[10])
        {
            Description = 'SDT V1.00';
            // TableRelation = "Groupe Retenue".Code where("Type Retenue" = filter("à la source"));
        }
        field(50009; "Groupe Comptabilisation"; Code[10])
        {
            Description = 'SDT V1.00';
        }
        field(50010; "N° Bordereau"; Code[20])
        {
            Description = 'SDT V1.00';
            Editable = false;
        }
        field(50011; Remplaced; Boolean)
        {
            Caption = 'Remplacé';
            Description = 'SDT V1.00';
        }
        field(50012; "Payement Crédit"; Boolean)
        {
            Description = 'SDT V1.00';
        }
        field(50014; "Header Account Type"; Option)
        {
            Caption = 'Account Type Header';
            Description = 'SDT V1.00';
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(50015; "Header Account No."; Code[20])
        {
            Caption = 'Account No. Header';
            Description = 'SDT V1.00';
            Editable = false;
            TableRelation = if ("Header Account Type" = const("G/L Account")) "G/L Account"
            else
            if ("Header Account Type" = const(Customer)) Customer
            else
            if ("Header Account Type" = const(Vendor)) Vendor
            else
            if ("Header Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Header Account Type" = const("Fixed Asset")) "Fixed Asset";
        }
        field(50018; "Type Engagement"; Option)
        {
            Description = 'HJ DSFT 08-02-2014';
            OptionMembers = " ",Fournisseur,Banque,"Fournisseur Et Banque","Client Et Banque",Client;
        }
        field(50019; "Sens Engagement"; Option)
        {
            Description = 'HJ DSFT 08-02-2014';
            OptionMembers = " ","Débit","Crédit";
        }
        field(50050; "Montant Retenue"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50051; "Montant Retenue Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50055; "Montant Retenue DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50056; "Montant Retenue Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50070; "Montant Retenue TVA"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50071; "Montant Retenue TVA Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50075; "Montant Retenue TVA DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50076; "Montant Retenue TVA Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50080; "Montant TVA sur Commission"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50081; "Montant TVA sur Commission DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50082; "Montant Commission"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50083; "Montant Commission DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50090; "Montant TVA sur Com. validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50091; "Montant TVA sur Com. validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50092; "Montant Commission Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50093; "Montant Commission Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50100; Commentaires; Text[150])
        {
            Description = 'SDT V1.00';
        }
        field(50101; "Montant Initial"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50102; "Montant Initial DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50200; "Avance ouvert"; Boolean)
        {
            Description = 'SDT V1.00';
        }
        field(50201; "Montant Ouvert"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50202; "Montant Ouvert DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50300; "Job No."; Code[20])
        {
            Description = 'SDT V1.00';
        }
        field(50408; "Code Retenue de Garantie"; Code[10])
        {
            Description = 'SDT V1.00';
            // TableRelation = "Groupe Retenue".Code where("Type Retenue" = filter("de garantie"));
        }
        field(50450; "Montant Retenue G."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50451; "Montant Retenue G. Validé"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Description = 'SDT V1.00';
        }
        field(50455; "Montant Retenue G. DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50456; "Montant Retenue G. Validé DS"; Decimal)
        {
            AutoFormatType = 2;
            Description = 'SDT V1.00';
        }
        field(50501; "N° Salarié"; Code[20])
        {
            Description = 'SDT V1.00';
            TableRelation = Employee;
        }
        field(50502; "N° compte En tête"; Code[20])
        {
            CalcFormula = lookup("Payment Header"."Account No." where("No." = field("No.")));
            Caption = 'Account Type Header';
            Description = '*';
            FieldClass = FlowField;
        }
        field(50507; "Référence chèque"; Code[20])
        {
            Description = 'MBK';
            Editable = false;
            TableRelation = "Référence Chèques";

            trigger OnLookup()
            var
                "Listréférencechèques_lf": page "List référence chèques";
                "RéférenceChèques_lr": Record "Référence Chèques";
                PaymentHeader_lr: Record "Payment Header";
                "Chèquemouvementé_lr": Record "Chèque mouvementé";
                Text0010: label 'Référence chèque non valide';
                Text0011: label 'Veuillez choisir le N° de compte';
            begin
            end;
        }
        field(50508; "N° chèque"; Integer)
        {
            Description = 'MBK';

            trigger OnValidate()
            var
                "RéférenceChèques_lr": Record "Référence Chèques";
                PaymentHeader_lr: Record "Payment Header";
                "Chèquemouvementé_lr": Record "Chèque mouvementé";
                Text001: label 'Numéro utilisé';
                Text002: label 'Numéro hors intervalle';
                Text003: label 'Numéro bloqué';
            begin
            end;
        }
        field(50509; "Code compte"; Code[20])
        {
            Description = 'AGA';
            TableRelation = if ("Type de compte" = const("G/L Account")) "G/L Account"
            else
            if ("Type de compte" = const(Customer)) Customer
            else
            if ("Type de compte" = const(Vendor)) Vendor
            else
            if ("Type de compte" = const("Bank Account")) "Bank Account"
            else
            if ("Type de compte" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Type de compte" = const("Frais annexe")) "Item Charge";

            trigger OnValidate()
            var
                RecItemCharge: Record "Item Charge";
                RecGeneralPostingSetup: Record "General Posting Setup";
                TEXT001: label 'Vous devez spécifier le compte achat dans le groupe compta produit ';
                TEXT002: label 'groupe compta marché';
            begin
            end;
        }
        field(50510; "Type de compte"; Option)
        {
            Description = 'AGA';
            OptionCaption = 'Général,Client,Fournisseur,Banque,Immobilisation,Frais annexe';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","Frais annexe";
        }
        field(50511; Agence; Code[20])
        {
            Description = 'HJ DSFT 09 12 2010';
        }
        field(50512; Utilisateur; Code[20])
        {
            Description = 'HJ DSFT 09 12 2010';
        }
        field(50513; "Jours Restants"; Integer)
        {
            Description = 'MBK';
        }
        field(50514; "Intérêt FED"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50515; "Intérêt FED (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 11 05 2011';
        }
        field(50516; "Intérêt Escompte"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50517; "Intérêt Escompte (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 11 05 2011';
        }
        field(50518; "Intérêt FED Validé"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50519; "Intérêt FED (DS) validé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 11 05 2011';
        }
        field(50520; "Intérêt Escompte validé"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50521; "Intérêt Escompte (DS) validé"; Decimal)
        {
            Description = 'IMS 11 05 2011';
        }
        field(50522; "Intérêt sur Prêt"; Decimal)
        {
            Description = 'IMS 02 06 2011';
        }
        field(50523; "Intérêt sur Prêt (DS)"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 02 06 2011';
        }
        field(50524; "Intérêt sur Prêt Validé"; Decimal)
        {
            Description = 'IMS 02 06 2011';
        }
        field(50525; "Intérêt sur Prêt (DS) validé"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'IMS 02 06 2011';
        }
        field(50526; ABK; Boolean)
        {
            CalcFormula = lookup("Payment Class".EXT where(Code = field("Payment Class")));
            Description = 'HJ DSFT 04-10-2012';
            FieldClass = FlowField;
        }
        field(50527; "Motif Depense Extra"; Code[20])
        {
            Description = 'HJ DSFT 06-02-2014';
            // TableRelation = "Motif Depense Ext";
        }
        field(50528; "Mois Echeance"; Integer)
        {
            Description = 'HJ DSFT 06-02-2014';
        }
        field(50529; "Annee Echeance"; Integer)
        {
            Description = 'HJ DSFT 06-02-2014';
        }
        field(50530; "Marché"; Code[20])
        {
            Description = 'HJ DELTA 09-02-2014';
            TableRelation = Job;
        }
        field(50531; "Opération"; Option)
        {
            Description = 'HJ DELTA 09-02-2014';
            OptionMembers = "Contrôles Factures",Appro,Technique;
        }
        field(50532; "Type Ligne Credit"; Option)
        {
            Editable = false;
            OptionMembers = " ",Emis,Principal,Interet;
        }
        field(50533; "Comptabilisé"; Boolean)
        {
            Editable = false;
        }
        field(51000; "Agency Code soroubat"; Text[20])
        {
            Caption = 'Agency Code';
            DataClassification = ToBeClassified;
        }
        field(51001; "Drawee Reference soroubat"; Text[50])
        {
            Caption = 'Drawee Reference';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {

        key(Key3; "Payment Class", "Status No.", "Copied To No.", "Account Type", "Account No.")
        {
            SumIndexFields = Amount, "Amount (LCY)";
        }

        key(Key4; Amount, "No.")
        {
        }
    }


}

