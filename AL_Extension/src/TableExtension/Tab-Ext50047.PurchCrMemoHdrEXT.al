TableExtension 50047 "Purch. Cr. Memo Hdr.EXT" extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';
        }

        modify("Buy-from Vendor Name")
        {
            Caption = 'Buy-from Vendor Name';
        }
        modify("Buy-from Vendor Name 2")
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        modify("Buy-from Address")
        {
            Caption = 'Buy-from Address';
        }
        modify("Buy-from Address 2")
        {
            Caption = 'Buy-from Address 2';
        }
        modify("Buy-from City")
        {
            Caption = 'Buy-from City';
        }
        modify("Buy-from Contact")
        {
            Caption = 'Buy-from Contact';
        }
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from Post Code';
        }
        modify("Buy-from County")
        {
            Caption = 'Buy-from County';
        }
        modify("Buy-from Country/Region Code")
        {
            Caption = 'Buy-from Country/Region Code';
        }
        field(50001; "N° Dossier"; Code[20])
        {
            TableRelation = "Dossiers d'Importation"."N° Dossier" where("N° Fournisseur" = field("Buy-from Vendor No."));
        }

        field(50023; Demarcheur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(50037; Decharge; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50038; Imprimer; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50039; "N° Decharge"; Text[30])
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50040; "Date Decharge"; Date)
        {
            Description = 'MH SORO 06/06/2015';
        }

        field(60015; Engin; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            TableRelation = Véhicule;
        }
        field(60016; "Description Engin"; Text[50])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
    }
    keys
    {
        key(STG_Key9; "N° Decharge")
        {
        }
    }

    trigger OnInsert()
    VAR
        lMaskMgt: Codeunit "Mask Management";
    begin
        //MASK
        "Mask Code" := lMaskMgt.UserMask;
        //MASK//
    end;

}

