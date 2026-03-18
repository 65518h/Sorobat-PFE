Table 52048895 "Employee's days off Entry"
{//GL2024  ID dans Nav 2009 : "39001422"
    Caption = 'Employee''s days off Entry';
    DrillDownPageID = "Recorded Employee's Absences";
    LookupPageID = "Recorded Employee's Absences";

    fields
    {
        field(1; "Transaction No."; Integer)
        {
            Caption = 'N° transaction';
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'N° séquence';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'Date début';
        }
        field(5; "To Date"; Date)
        {
            Caption = 'Date fin';
            Editable = true;
        }
        field(6; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Code motif absence';
            TableRelation = "Cause of Absence";
        }
        field(7; Description; Text[60])
        {
            Caption = 'Description';
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(9; Unit; Option)
        {
            Caption = 'Unit';
            OptionCaption = 'Work day,Work hour';
            OptionMembers = "Journée de travail","Heure de travail";
        }
        field(10; "Impute on days off"; Boolean)
        {
            Caption = 'Impute on days off';
        }
        field(11; Comment; Boolean)
        {
            CalcFormula = exist("Human Resource Comment Line" where("Table Name" = const(7),
                                                                     "Table Line No." = field("Entry No."),
                                                                     "No." = field("Employee No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Posting month"; Option)
        {
            Caption = 'Mois de comptabilisation';
            OptionCaption = 'Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre';
            OptionMembers = January," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December";
        }
        field(16; "Posting year"; Integer)
        {
            Caption = 'Année de comptabilisation';
        }
        field(20; "Line type"; Option)
        {
            Caption = 'Line type';
            OptionCaption = ' ,Day off Right,Day off Consumption,Non paid,1/2 paid,Non Comptabiliser,Droit Recuperation,Consomation Recup,Jour férié payé ';
            OptionMembers = " ","Day off Right","Day off Consumption","Deductible of salary","1/2 paied","Non Comptabiliser","Droit Recuperation","Consomation Recup","Deductible of Prime","1/2 Paid deductible of prime","Jour  férié","Jour férier payé";
        }
        field(21; "Quantity (Days)"; Decimal)
        {
            Caption = 'Quantity (Days)';
        }
        field(22; "Quantity (Hours)"; Decimal)
        {
            Caption = 'Quantité (Heures)';
            DecimalPlaces = 0 : 2;
        }
        field(30; "Payment No."; Code[10])
        {
            Caption = 'Payment No.';
            TableRelation = "Rec. Salary Headers";
        }
        field(40; "Employee Posting Group"; Code[10])
        {
            TableRelation = "Employee Posting Group2";
        }
        field(41; "Global dimension 1"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(42; "Global dimension 2"; Code[20])
        {
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50; "Heure Debut"; Time)
        {
        }
        field(51; "Heure Fin"; Time)
        {
        }
        field(100; Comptabiliser; Boolean)
        {
        }
        field(50020; direction; Code[10])
        {
            TableRelation = Direction;
        }
        field(50021; service; Code[10])
        {
        }
        field(50022; section; Code[10])
        {
        }
        field(50101; Semaine; Integer)
        {
        }
        field(8099198; "User ID"; Code[20])
        {
            Editable = false;
            TableRelation = User;
        }
        field(8099199; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(39001410; "Motif D'absence"; Option)
        {
            OptionMembers = " ","Absence Irrég.","Congé sans Solde",Retard,"Congé de Maladie","Accident de travail","Congé","Congé Spécial";
        }
        field(39001430; Correction; Boolean)
        {
        }
        field(39001440; "Montant Ligne"; Decimal)
        {
            AutoFormatType = 2;
        }
        field(39001450; "Entry No. Autorisation"; Integer)
        {
        }
        field(39001460; "Date Validité"; Date)
        {
        }
        field(39001470; "Recuperation Entry No."; Integer)
        {
        }
        field(39001480; "Nbre Heures recup"; Decimal)
        {
            CalcFormula = sum("Employee's days off Entry"."Quantity (Hours)" where("Line type" = filter("Droit Recuperation" | "Consomation Recup"),
                                                                                    "Employee No." = field("Employee No."),
                                                                                    "Entry No. Autorisation" = field("Entry No. Autorisation")));
            FieldClass = FlowField;
        }
        field(39001488; Nom; Text[30])
        {
            Editable = false;
        }
        field(39001489; prenom; Text[60])
        {
            Editable = false;
        }
        field(39001490; "N° seq Chantier"; Integer)
        {
        }
        field(39001491; "Jours trans"; Boolean)
        {
        }
        field(39001492; "Employee Statistic Group"; Code[10])
        {
            TableRelation = "Employee Statistics Group";
        }
        field(39001493; Quinzaine; Option)
        {
            OptionCaption = '1er,2ème,Autre';
            OptionMembers = "1er","2ème",Autre;
        }
    }

    keys
    {
        key(STG_Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(STG_Key2; "Posting year", "Posting month", "From Date", "Line type", "Entry No.")
        {
        }
        key(STG_Key3; "Transaction No.", "Entry No.", "Employee No.")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key4; "Cause of Absence Code", "To Date")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key5; "Line type", "Employee No.", "To Date")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key6; "Employee No.", "Posting month", "Posting year", "Line type", "Payment No.", "From Date", "To Date")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key7; "Employee Posting Group", "Employee No.", "Global dimension 1", "Global dimension 2", "Line type", "Posting month", "Posting year", "Payment No.")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key8; "Line type", "Employee No.", "Posting month", "Posting year", "Payment No.")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Montant Ligne", "Quantity (Hours)";
        }
        key(STG_Key9; "Line type", "Employee No.", "From Date", "To Date", "Heure Debut")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key10; "Line type", "Employee No.", "From Date", "To Date", "Heure Debut", "Heure Fin")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key11; "Posting year", "Line type", "Cause of Absence Code", "Employee No.")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key12; "Employee No.", "Posting year", "Posting month", "Line type", "Impute on days off")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key13; "Entry No. Autorisation", "Entry No.")
        {
        }
        key(STG_Key14; "Employee No.", "From Date", direction, "Cause of Absence Code", "Entry No.")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key15; "Employee No.", "Line type", "From Date")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key16; "Line type", "Employee No.", "Date Validité", "Entry No.")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key17; "Line type", "Employee No.", "Entry No. Autorisation")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key18; "Employee No.", "Posting year", "Posting month", "Cause of Absence Code", "Motif D'absence")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key19; "Employee No.", "Line type", "Date Validité")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key20; "Employee No.", "Posting year", "Transaction No.", "Line type")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key21; "Employee No.", "Posting month", "Posting year", Quantity)
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key22; "Cause of Absence Code", "Transaction No.", "Entry No.", "Employee No.", "From Date", "To Date")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key23; "Employee No.", "From Date", "Line type")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key24; "Employee No.", "From Date", "Motif D'absence")
        {
        }
        key(STG_Key25; "Employee No.", "Posting year", "Posting month", "Motif D'absence")
        {
        }
        key(STG_Key26; "N° seq Chantier", "Entry No.")
        {
        }
        key(STG_Key27; "Employee No.", "Posting year", "Posting month", "Motif D'absence", Semaine, Quinzaine)
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key28; "Employee No.", "Posting year", "Cause of Absence Code", "Posting month")
        {
            SumIndexFields = Quantity, "Quantity (Days)";
        }
        key(STG_Key29; "Employee Statistic Group", "Line type", "Posting year", "Posting month")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Quantity (Hours)";
        }
        key(STG_Key30; "Line type", "Employee No.", "Posting month", "Posting year", Quinzaine)
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Montant Ligne", "Quantity (Hours)";
        }
        key(STG_Key31; "Employee No.", "Posting month", "Posting year", "Motif D'absence")
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Montant Ligne", "Quantity (Hours)";
        }
        key(STG_Key32; "Line type", "Employee No.", "Posting month", "Posting year", Quinzaine, "Motif D'absence", Unit)
        {
            SumIndexFields = Quantity, "Quantity (Days)", "Montant Ligne", "Quantity (Hours)";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Rec39001532.Reset;
        Rec39001532.SetRange("N°Sequence", "Entry No.");
        if Rec39001532.Find('-') then
            repeat
                Rec39001532.Delete;
            until Rec39001532.Next = 0;
    end;

    var
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record Employee;
        Rec39001532: Record "Detail de congé consommé";
}

