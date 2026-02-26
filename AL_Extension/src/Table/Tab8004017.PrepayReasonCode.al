Table 8004017 "Prepay Reason Code"
{
    // //ADPGSI CW 10/03/03 Ajout "Format ADPGSI"

    Caption = 'Cause of pay code';
    // DrillDownPageID = 8004017;
    // LookupPageID = 8004017;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Désignation';
        }
        field(3; "Unit Code"; Code[10])
        {
            Caption = 'Code unité';
            TableRelation = "Unit of Measure";
        }
        field(4; "Reason Total"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Prepay Ledger Entry"."Quantity (Base)" where("Prepay Reason Code" = field(Code),
                                                                             "Employee No." = field("Employee Filter"),
                                                                             "From Date" = field("Date Filter")));
            Caption = 'Total Motif';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Department Filter"; Code[10])
        {
            Caption = 'Filtre département';
            FieldClass = FlowFilter;
            //GL2024    TableRelation = Table11;
        }
        field(6; "Project Filter"; Code[10])
        {
            Caption = 'Filtre dossier';
            FieldClass = FlowFilter;
            //GL2024    TableRelation = Table12;
        }
        field(7; "Employee Filter"; Code[20])
        {
            Caption = 'Filtre N° salarié';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(8; "Date Filter"; Date)
        {
            Caption = 'Filtre date';
            FieldClass = FlowFilter;
        }
        field(50000; "ADP/GSI Format"; Option)
        {
            Caption = 'Format ADP/GSI';
            OptionCaption = ' ,Pointage (409),Elément (609),Période saisie (409),Régul. (709)';
            OptionMembers = " ","Pointage (409)","Elément (609)","Période saisie (409)","Régul. (709)";
        }
        field(50001; "ADP/GSI Code"; Code[10])
        {
            Caption = 'Code ADP/GSI';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

