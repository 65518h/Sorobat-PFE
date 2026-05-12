TableExtension 50157 "Fixed AssetEXT" extends "Fixed Asset"
{
    fields
    {


        field(50000; "Ancien Code"; Code[20])
        {
            Caption = 'Ancien Code';
            Description = 'BSK 24/04/2012';
        }
        field(50001; "Materiel Exploiatation"; Boolean)
        {
            Description = 'BSK 20/06/2012';
        }
        field(50002; Famille; Code[20])
        {
            Description = 'HJ DSFT 21-06-2012';
            TableRelation = Tree.Code where(Type = const(Machine));
        }
        field(50003; "Matériel"; Boolean)
        {
            Description = 'HJ DSFT 21-06-2012';
        }
        field(50004; "Non Amortissable"; Boolean)
        {
            Description = 'HJ SORO 14-03-2016';
        }
        field(50005; "N° Facture Fournisseur"; Code[20])
        {
            CalcFormula = lookup("FA Ledger Entry"."External Document No." where("FA No." = field("No."),
                                                                                  "Document Type" = filter(Invoice),
                                                                                  "FA Posting Type" = filter("Acquisition Cost")));
            Description = 'RB SORO 07/09/2017';
            FieldClass = FlowField;
        }
        field(50006; "Date Comptabilisation"; Date)
        {
            CalcFormula = lookup("FA Ledger Entry"."Posting Date" where("FA No." = field("No."),
                                                                         "Document Type" = filter(Invoice),
                                                                         "FA Posting Type" = filter("Acquisition Cost")));
            Description = 'RB SORO 07/09/2017';
            FieldClass = FlowField;
        }
        field(50007; "N° Facture"; Code[20])
        {
            CalcFormula = lookup("FA Ledger Entry"."Document No." where("FA No." = field("No."),
                                                                         "Document Type" = filter(Invoice),
                                                                         "FA Posting Type" = filter("Acquisition Cost")));
            Description = 'RB SORO 07/09/2017';
            FieldClass = FlowField;
        }
        field(50008; "Groupe Immo"; Code[20])
        {
            CalcFormula = lookup("FA Depreciation Book"."FA Posting Group" where("FA No." = field("No.")));
            Description = 'HJ SORO 11-09-2017';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50009; "Date Acquisition"; Date)
        {
            CalcFormula = lookup("FA Depreciation Book"."Acquisition Date" where("FA No." = field("No.")));
            Description = 'HJ SORO 11-09-2017';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "Attaché Materiel"; Boolean)
        {
            Description = 'HJ SORO 18-09-2017';
        }
        field(51000; "Description Soroubat"; text[100])
        {

        }
        field(51001; "Search Description Soroubat"; text[100])
        {

        }
        field(8003900; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
    }
    trigger OnBeforeInsert()
    begin
        //+REF+TEMPLATE
        IF ("No." = '') AND ("No. Series" <> '') THEN
            NoSeriesMgt.InitSeries("No. Series", "No. Series", 0D, "No.", "No. Series");
        //+REF+TEMPLATE//  
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;


}

