TableExtension 50043 "Purch. Rcpt. HeaderEXT" extends "Purch. Rcpt. Header"
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
        modify("Pay-to Contact no.")
        {

            Caption = 'Pay-to Contact No.';
        }
        field(50000; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Stamp Fiscal';
            Description = 'STD V1.0';
            InitValue = false;
        }
        field(50001; "N° Dossier"; Code[20])
        {
            TableRelation = "Dossiers d'Importation"."N° Dossier" where("N° Fournisseur" = field("Buy-from Vendor No."));

            trigger OnValidate()
            var
                LigAchat: Record "Purchase Line";
            begin
            end;
        }
        field(50005; Synchronise; Boolean)
        {
        }
        field(50006; "Num Sequence Syncro"; Integer)
        {
            Description = 'RB SORO 06/03/2015';
        }
        field(50008; "Date Dossier"; Date)
        {
            Description = 'MBY';
        }
        field(50011; "N° Demande d'achat"; Code[20])
        {
            Description = 'HJ DSFT 27-04-2012';
            Editable = false;
        }
        field(50012; "Date DA"; Date)
        {
            Description = 'HJ DSFT 01-02-2013';
        }
        field(50115; Engin; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            TableRelation = Véhicule;
        }
        field(50116; "Description Engin"; Text[50])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50023; Demarcheur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(50024; Contrat; Boolean)
        {
        }
        field(50025; "Date Bureau Ordre"; Date)
        {
        }
        field(50026; "Date Saisie"; Date)
        {
            Description = 'HJ SORO 03-02-2015';
        }
        field(50030; "Motif Annulation"; Text[30])
        {
            Description = 'RB SORO 10/04/2015';
        }
        field(50031; "N° DA Chantier"; Code[20])
        {
            Description = 'RB SORO 17/04/2015';
        }
        field(50032; Demandeur; Code[50])
        {
            Description = 'HJ SORO 18-04-2015';
        }
        field(50033; Engins; Code[20])
        {
            Description = 'HJ SORO 18-04-2015';
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
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(8013924; "Date Received"; date)
        {

        }
        field(8013925; "Time Received"; Time)
        {

        }
        field(8013926; "BizTalk Purchase Receipt"; Boolean)
        {

        }
    }
    keys
    {
        key(Key7; Synchronise)
        {
        }
    }
}

