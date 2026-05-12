TableExtension 50878 "Job Planning LineEXT" extends "Job Planning Line"
{
    fields
    {
        field(55000; "Cumulative Executed Qty"; Decimal)
        {
            Caption = 'Cumulative Executed Qty', Comment = 'Qté cumulée exécutée';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Job Ledger Entry"."Executed measurement" where("Job No." = field("Job No."), "Job Task No." = field("Job Task No."),
                                                                    "Entry Type" = filter(Usage)));
        }
        field(55001; "Monthly Executed Qty"; Decimal)
        {
            Caption = 'Monthly Executed Qty', Comment = 'Qté exécutée du mois';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Job Ledger Entry"."Executed measurement" where("Job No." = field("Job No."), "Job Task No." = field("Job Task No."), "Entry Type" = filter(Usage), "Posting Date" = field("Date Filter")));
        }
        field(55002; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code';
            TableRelation = Mask;
        }
        field(8003904; "Resource Type"; Option)
        {
            Caption = 'Resource Type';
            OptionCaption = 'Person,Machine,Structure,Other';
            OptionMembers = Person,Machine,Structure,Other;
        }
        field(8003905; "Global Dimension 1 Code"; Code[20])
        {
            //CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(8003906; "Global Dimension 2 Code"; Code[20])
        {
            //CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(8003909; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Editable = false;
            OptionCaption = 'Initial,Audit,Difference';
            OptionMembers = Initial,Audit,Difference;
        }
        field(8003910; "Cession Transferred"; Boolean)
        {
            Caption = 'Cession Transferred';
        }
        field(8003911; "Gross Total Cost"; Decimal)
        {
            Caption = 'Gross Total Cost';
            Editable = false;
        }
        field(8003919; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(8004055; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
    }
    /*GL2024   keys
      {

          key(STG_Key12; "Document Type", "Document No.")
          {
          }
          key(STG_Key13; "Job No.", Type, "Resource Type", "Gen. Prod. Posting Group", "Entry Type", "Planning Date")
          {
              SumIndexFields = "Quantity (Base)", "Total Price (LCY)", "Total Cost (LCY)", "Line Amount (LCY)", "Gross Total Cost", Quantity, "Total Cost", "Total Price";
          }
          key(STG_Key14; "Job No.", Type, "No.", "Work Type Code", "Planning Date")
          {
              SumIndexFields = "Quantity (Base)";
          }
          key(STG_Key15; "Gen. Prod. Posting Group")
          {
              SumIndexFields = "Total Price (LCY)";
          }
          key(STG_Key16; "Job No.", "Job Task No.", "Gen. Prod. Posting Group", Type, "Resource Type", "No.", "Variant Code", "Entry Type", "Planning Date", "Order Date", "Global Dimension 1 Code", "Global Dimension 2 Code")
          {
              SumIndexFields = Quantity, "Total Cost", "Total Cost (LCY)", "Total Price", "Gross Total Cost", "Quantity (Base)", "Line Amount (LCY)";
          }
      }*/

    trigger OnAfterInsert()
    begin
        GetJob();
        //MASK
        "Mask Code" := Job."Mask Code";
        //MASK//
    end;

    procedure wSetType(pType: Option " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)")
    begin
        //PROJET
        case pType of
            Ptype::" ":
                Type := Type::Text;
            Ptype::"G/L Account":
                Type := Type::"G/L Account";
            Ptype::Item:
                Type := Type::Item;
            Ptype::Resource:
                Type := Type::Resource;
            //  pType::"Fixed Asset":
            Ptype::"Charge (Item)":
                Type := Type::"G/L Account";
        end;
        //PROJET//
    end;



    procedure UpdateCostLCY()
    begin
        "Unit Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Unit Cost", "Currency Factor"),
            Currency."Unit-Amount Rounding Precision");
        "Total Cost (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Total Cost", "Currency Factor"),
            Currency."Amount Rounding Precision");
    end;


    procedure UpdatePriceFCY()
    begin
        "Unit Price" := ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              "Currency Date", "Currency Code",
              "Unit Price (LCY)", "Currency Factor"),
            Currency."Unit-Amount Rounding Precision");
        "Total Price" := ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
              "Currency Date", "Currency Code",
              "Total Price (LCY)", "Currency Factor"),
            Currency."Amount Rounding Precision");
    end;


    procedure UpdatePriceLCY()
    begin
        GLSetup.Get();
        "Unit Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Unit Price", "Currency Factor"),
            GLSetup."Unit-Amount Rounding Precision");
        "Total Price (LCY)" := ROUND(
            CurrExchRate.ExchangeAmtFCYToLCY(
              "Currency Date", "Currency Code",
              "Total Price", "Currency Factor"));
    end;

    var
        CurrExchRate: Record 330;
        Currency: Record 4;
        GLSetup: Record 98;
}