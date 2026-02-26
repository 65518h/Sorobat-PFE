TableExtension 50038 "Sales Shipment LineEXT" extends "Sales Shipment Line"
{
    fields
    {
        /*  GL2024
        modify("Sell-to Customer No.")
          {
              Editable=true;
          }

            modify("VAT %")
          {
              Editable=true;
          }

            modify("Qty. Shipped Not Invoiced")
          {
              Editable=true;
          }
             modify("Quantity Invoiced")
          {
              Editable=true;
          }
             modify("Bill-to Customer No.")
          {
              Editable=true;
          }
              modify("Qty. Invoiced (Base)")
          {
              Editable=true;
          }
          */


        modify("Job No.")
        {
            Caption = 'Job No.';
            Description = 'TestTableRelation=No';
            //GL2024  TestTableRelation =false;

        }
        /*  modify("Sell-to Customer No.")
          {
              Editable = false;
          }*/

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
            trigger OnAfterValidate()
            var

                JobPlanningLine: Record "Job Planning Line";
            begin

            end;
        }


        field(50000; "N° BL Central"; Code[20])
        {
            CalcFormula = lookup("Sales Shipment Header"."External Document No." where("No." = field("Document No.")));
            Description = 'HJ SORO 04-08-2015';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "Date Compta"; Date)
        {
            CalcFormula = lookup("Sales Shipment Header"."Posting Date" where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50003; Montant; Decimal)
        {
        }
        field(50004; "Quantité Avoir"; Decimal)
        {
            DecimalPlaces = 3 : 3;
            Description = 'HJ SORO 12-08-2018';

            trigger OnValidate()
            begin
                if not Confirm(Text002) then exit;
            end;
        }
        /*  field(50005; "Date Debut Decompte"; Date)
          {
              CalcFormula = lookup("Sales Shipment Header"."Date Debut Decompte" where("No." = field("Document No.")));
              Editable = false;
              FieldClass = FlowField;
          }
          field(50006; "Date Fin Decompte"; Date)
          {
              CalcFormula = lookup("Sales Shipment Header"."Date Fin Decompte" where("No." = field("Document No.")));
              Editable = false;
              FieldClass = FlowField;
          }*/
        field(51000; "Description 2 soroubat"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50170; "Type article"; Enum "Item Type")
        {
            trigger OnValidate()
            var
            begin

            end;
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
        field(8003904; "Job Budget Entry ID"; Integer)
        {
            Caption = 'Job Budget Entry ID';
        }
        field(8003916; Marker; Code[20])
        {
            Caption = 'Marker';
        }
        field(8004050; "Line Type"; Option)
        {
            Caption = 'Line Type';
            OptionCaption = ' ,Totaling,Item,Person,Machine,Structure,G/L Account,Charge (Item),Other,Fixed Asset';
            OptionMembers = " ",Totaling,Item,Person,Machine,Structure,"G/L Account","Charge (Item)",Other,"Fixed Asset";
        }
        field(8004056; "Presentation Code"; Text[20])
        {
            Caption = 'Presentation Code';
        }
        field(8004057; Level; Integer)
        {
            Caption = 'Level';
        }
    }
    keys
    {


        key(Key8; "Job Budget Entry ID")
        {
            //GL2024  SumIndexFields = "Quantity (Base)";
        }
        /* GL2024
                key(Key9;"Document No.","Presentation Code")
                {
                }*/

        /*  key(Key10; "VAT %")
          {
          }*/
    }

    var
        TextRef: label 'Ship. No. %1 - %3 / Your Ref %2 :';
        Text002: label 'Confirmer Cette Action ?';

        Currency: Record Currency;
        CurrencyRead: Boolean;
}

