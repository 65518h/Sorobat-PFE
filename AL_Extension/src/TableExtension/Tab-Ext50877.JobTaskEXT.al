TableExtension 50877 "Job TaskEXT" extends "Job Task"
{
    fields
    {
        field(50000; "Date Debut"; Date)
        {
            Description = 'HJ DSFT 01 06 2012';
        }
        field(50001; "Date Fin"; Date)
        {
            Description = 'HJ DSFT 01 06 2012';
        }
        field(50010; Predecesseur; Code[10])
        {
            Description = 'HJ DSFT 01 06 2012';
        }
        field(51000; "Importance %"; Decimal)
        {
        }
        field(51001; "Quantité Contractuelle"; Decimal)
        {
            CalcFormula = sum("Sales Line".Quantity where("Job No." = field("Job No."),
                                                           "Job Task No." = field("Job Task No."),
                                                           "Line Type" = const(Structure)));
            Caption = 'Budget Date', Comment = 'Quantité Contractuelle';
            FieldClass = FlowField;
        }
        field(51002; "Progress %"; Decimal)
        {
            Caption = 'Progress %', Comment = '% Avancement';
        }
        field(51003; "Task Progress %"; Decimal)
        {
            Caption = 'Task Progress %', Comment = '% Avancement Tâche';
        }
        field(51004; "Remaining Quantity"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Outstanding Quantity" where("Job No." = field("Job No."),
                                                                         "Job Task No." = field("Job Task No."),
                                                                         "Line Type" = const(Structure)));
            FieldClass = FlowField;
            Caption = 'Remaining Quantity', Comment = 'Quantité Restante';
        }
        field(51005; "Quantity Shipped"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Quantity Shipped" where("Job No." = field("Job No."),
                                                                     "Job Task No." = field("Job Task No."),
                                                                     "Line Type" = const(Structure)));
            FieldClass = FlowField;
            Caption = 'Quantity Shipped', Comment = 'Quantité Réalisée';
        }
        field(51006; "Starting Index"; Code[10])
        {
            Caption = 'Starting Index', Comment = 'Index de départ';
        }
        field(51007; "Ending Index"; Code[10])
        {
            Caption = 'Ending Index', Comment = 'Index de fin';
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Mask Code', Comment = 'Code masque';
            TableRelation = Mask;
        }
        field(8003900; Blocked; Boolean)
        {
            Caption = 'Blocked', Comment = 'Bloqué';
        }
        field(50100; "DYSOutstanding Orders"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = sum("Purchase Line"."Outstanding Amt. Ex. VAT (LCY)" where("Document Type" = const(Order),
                                                                                      "DYSJob No." = field("Job No."),
                                                                                      "DYSJob Task No." = field("Job Task No."),
                                                                                      "DYSJob Task No." = field(filter(Totaling))));
            Caption = 'Outstanding Orders', Comment = 'Commandes en cours';
            FieldClass = FlowField;
            Editable = false;
        }
        field(50101; "DYSAmt. Rcd. Not Invoiced"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = sum("Purchase Line"."A. Rcd. Not Inv. Ex. VAT (LCY)" where("Document Type" = const(Order),
                                                                                      "DYSJob No." = field("Job No."),
                                                                                      "DYSJob Task No." = field("Job Task No."),
                                                                                      "DYSJob Task No." = field(filter(Totaling))));
            Caption = 'Amt. Rcd. Not Invoiced', Comment = 'Montant reçu non facturé';
            FieldClass = FlowField;
            Editable = false;
        }
        field(60100; "Initial Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Initial Quantity', Comment = 'Quantité Vendue';
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(60101; "Initial Unit Of Measure"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
            Caption = 'Initial Unit Of Measure', Comment = 'Unité De Mesure Vendue';
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(60102; "Initial Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Initial Unit Price', Comment = 'Prix Unitaire Vendu';
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(60103; "Initial Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Initial Amount', Comment = 'Prix Total Vendu';
            Editable = false;
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }

    }
    local procedure UpdateAmount()
    var
        myInt: Integer;
    begin
        Rec."Initial Amount" := Rec."Initial Quantity" * Rec."Initial Unit Price";
    end;

}