TableExtension 50040 "Sales Invoice LineEXT" extends "Sales Invoice Line"
{
    fields
    {
        /* GL2024   modify("Sell-to Customer No.")
            {
                Editable = true;
            }

             modify("Bill-to Customer No.")
            {
                Editable = true;
            }

            */



        modify("Job No.")
        {
            Caption = 'Job No.';
            //GL2024   TestTableRelation = false;
            Description = 'TestTableRelation=No';


        }


        modify("Gen. Prod. Posting Group")
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
        }
        modify("Job Contract Entry No.")
        {
            Caption = 'Job Contract Entry No.';
        }

        field(50000; Produit; Text[100])
        {
            CalcFormula = lookup(Item.Description where("No." = field("No.")));
            FieldClass = FlowField;
        }
        field(50001; Client; Text[100])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Sell-to Customer No.")));
            FieldClass = FlowField;
        }
        field(50021; "Apply Fodec"; Boolean)
        {
        }
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60003; "Quantité Intiale Marché"; Decimal)
        {
            DecimalPlaces = 0 : 2;
            Editable = false;
        }
        field(60004; "Avenant 1"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                VALIDATE(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            end;
        }
        field(60005; "Type DA"; Option)
        {
            OptionMembers = "Consultation Externe","Consultation Interne";
        }
        field(60006; "Avenant 3"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                VALIDATE(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            end;
        }
        field(60007; "Avenant 4"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                VALIDATE(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            end;
        }
        field(60008; "Montant Initiale Marché"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(60009; "Prix Unitaire  Initiale Marché"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Editable = false;
        }
        field(60010; "Avenant 2"; Decimal)
        {
            DecimalPlaces = 0 : 2;

            trigger OnValidate()
            begin
                VALIDATE(Quantity, "Avenant 1" + "Type DA" + "Avenant 3" + "Avenant 4" + "Quantité Intiale Marché");
            end;
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
            Description = 'New';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
            Description = 'New';
        }
        field(8001903; "Contract Base Unit Price"; Decimal)
        {
            Caption = 'Contract Base Unit Price';
        }
        field(8003903; "Scheduler Line No."; Integer)
        {
            Caption = 'Scheduler Line No.';
            Editable = false;
        }
        field(8003916; Marker; Code[20])
        {
            Caption = 'Marker';
        }
        field(8003981; "Invoice No."; Code[20])
        {
            Caption = 'Invoice/Cr. Memo No.';
        }
        field(8003991; "Rider Rank"; Integer)
        {
            Caption = 'Rider Rank';
        }
        field(8003992; "Quote No."; Code[20])
        {
            Caption = 'Quote No.';
        }
        field(8003993; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(8003994; "Order Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Order Amount';
        }
        field(8003995; "Invoiced Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Invoiced Amount';
        }
        field(8003997; "Prepayment Order No."; Code[20])
        {
            Caption = 'Prepayment Order No.';
        }
        field(8003998; "Prepayment Order Line No."; Integer)
        {
            Caption = 'Prepayment Order Line No.';
        }
        field(8003999; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate()
            var
                GenPostingSetup: Record "General Posting Setup";
                GLAcc: Record "G/L Account";
            //  lPrepaymentMgt: Codeunit "Prepayment Management";
            begin
            end;
        }
        field(8004050; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Totaling,Item,Person,Machine,Structure,G/L Account,Charge (Item),Other,Fixed Asset';
            OptionMembers = " ",Totaling,Item,Person,Machine,Structure,"G/L Account","Charge (Item)",Other,"Fixed Asset";
        }
        field(8004052; "Structure Line No."; Integer)
        {
            Caption = 'Structure Line No.';
        }
        field(8004056; "Presentation Code"; Text[20])
        {
            Caption = 'Presentation Code';

            trigger OnValidate()
            var
                lSalesLine: Record "Sales Line";
                lSalesLineBis: Record "Sales Line" temporary;
                lTabCodeNew: array[20] of Integer;
                lTabCode: array[20] of Integer;
                lCode: Text[80];
                i: Integer;
            begin
            end;
        }
        field(8004057; Level; Integer)
        {
            Caption = 'Level';
        }
        field(8004092; "Vendor Ledger Entry No."; Integer)
        {
            Caption = 'Vendor Ledger Entry No.';
        }
    }
    keys
    {
        key(Key14; "Prepayment Order No.", "Prepayment Order Line No.")
        {
        }

        /* GL2024  key(Key15;"Document No.","Presentation Code","Line No.")
           {
           }*/

        key(Key16; "VAT %")
        {
        }

        key(Key17; Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
        {
        }
    }
}

