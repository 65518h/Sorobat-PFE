TableExtension 50132 "Purchase Header ArchiveEXT" extends "Purchase Header Archive"
{
    fields
    {


        modify("Posting from Whse. Ref.")
        {
            Caption = 'Posting from Whse. Ref.';
        }
        field(50001; "N° Dossier"; Code[20])
        {
            Description = 'HJ DSFT 01 030 2012';
            TableRelation = "Dossiers d'Importation"."N° Dossier";
        }
        field(50002; "N° Sequence"; Integer)
        {
        }
        field(50003; "Type Demande"; Option)
        {
            Description = 'HJ DSFT';
            OptionMembers = "Piece De Rechange",Meteriaux,"Fourniture Et Divers","Prestation De service";
        }
        field(50004; Approbateur; Code[20])
        {
            Description = 'HJ DSFT 18-10-2012';
        }
        field(50005; Synchronise; Boolean)
        {
        }
        field(50008; "Date Dossier"; Date)
        {
            Description = 'HJ DSFT 01 030 2012';
        }
        field(50011; "N° Demande d'achat"; Code[20])
        {
            Editable = true;
        }
        field(50012; "Date DA"; Date)
        {
            Description = 'HJ DSFT 01-02-2013';
        }
        field(50014; "Statut Commande"; Option)
        {
            Editable = false;
            OptionMembers = " ","Non Livré","Partiellement Livré","Totallement Livré";
        }
        field(50016; "Remarque de Livrison"; Text[100])
        {
            Description = 'RB SORO 29/12/2015';
        }
        field(51000; "Pay-to Address Soroubat"; Text[100])
        {
            Caption = 'Pay-to Address Soroubat';
        }
        field(51001; "Pay-to Address 2 Soroubat"; Text[100])
        {
            Caption = 'Pay-to Address 2 Soroubat';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Code Masque';
            TableRelation = Mask;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Date de début d''abonnement';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Date de fin d''abonnement';
        }
        field(8001902; "Next Invoice Time"; DateFormula)
        {
            Caption = 'Next Invoice Time';
        }
        field(8001903; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
            Editable = false;
        }
        field(8001904; "Source Invoice No."; Code[20])
        {
            Caption = 'Source Invoice No.';
        }
        field(8003900; "Ship-to Job No."; Code[20])
        {
            Caption = 'Ship-to Address Job No.';
            TableRelation = Job;

            trigger OnValidate()
            var
                lJob: Record Job;
            begin
            end;
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'N° Affaire';
            TableRelation = Job."No." where("IC Partner Code" = const());

            trigger OnValidate()
            var
                lJob: Record Job;
                lJobStatus: Record "Job Status";
            begin
            end;
        }
        field(8004090; "Attached to Doc. No."; Code[20])
        {
            Caption = 'Attached to Doc. No.';
        }
        field(8004091; "Attached to Doc. Type"; Option)
        {
            Caption = 'Attached to Doc. Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(8004092; "Vendor Disc. Group"; Code[10])
        {
            Caption = 'Vendor Discount Group';
            TableRelation = "Vendor Discount Group";
        }
        field(8004093; "Remaining to Order"; Boolean)
        {
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"),
                                                       "Document No." = field("No."),
                                                       "Ordered Line" = filter(false)));
            Caption = 'Remaining to Order';
            FieldClass = FlowField;
        }
        field(8004094; "Price Offer Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line"."Line Amount" where("Document Type" = field("Document Type"),
                                                                   "Document No." = field("No.")));
            Caption = 'Amount Excl. VAT';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

