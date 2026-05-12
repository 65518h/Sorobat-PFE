TableExtension 50142 "Cause of AbsenceEXT" extends "Cause of Absence"
{
    fields
    {
        modify("Total Absence (Base)")
        {
            Description = 'Modification CalcFormula';

        }

        field(8099000; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Day off Right,Day off Consumption,Deductible of salary,1/2 paid,Droit Recuperayion,Consomation Recup,Deductible of Prime';
            OptionMembers = " ","Day off Right","Day off Consumption","Deductible of salary","1/2 paied","Non Comptabiliser","Droit Recuperation","Consomation Recup","Deductible of Prime","1/2 Paid deductible of prime","Jour  férié","Jour  férié payé ";
        }
        field(8099001; "Total validated Absence"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Employee's days off Entry".Quantity where("Cause of Absence Code" = field(Code),
                                                                          "Employee No." = field("Employee No. Filter"),
                                                                          "From Date" = field("Date Filter")));
            Caption = 'Total validated Absence';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8099198; "User ID"; Code[10])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001400; "Imputable Sur Congé"; Boolean)
        {
        }
        field(39001401; "Nbre de J (autorisée)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001402; "Nbre de J (auto. 1 Période)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001403; "Code Cause 1 Période"; Code[10])
        {
            TableRelation = "Cause of Absence";
        }
        field(39001404; "Nbre de J (auto. 2 Période)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001405; "Code Cause 2 Période"; Code[10])
        {
            TableRelation = "Cause of Absence";
        }
        field(39001406; "Nbre de J (auto. 3 Période)"; Decimal)
        {
            DecimalPlaces = 0 : 2;
        }
        field(39001407; "Code Cause 3 Période"; Code[10])
        {
            TableRelation = "Cause of Absence";
        }
        field(39001410; "Motif D'absence"; Option)
        {
            OptionMembers = " ","Absence Irrég.","Congé sans Solde",Retard,"Congé de Maladie","Accident de travail","Congé","Congé Spécial";
        }
    }
}

