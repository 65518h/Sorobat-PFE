Table 8001516 "Statistic sort criteria"
{
    //GL2024  ID dans Nav 2009 : "8001309"
    // //STATSEXPLORER STATSEXPLORER 01/10/01 Statistic sort criteria

    Caption = 'Statistic sort criteria';
    //LookupPageID = 8001309;

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Statistic sort';
            OptionMembers = "Tri statistique";
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(3; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(10; "1st sort level"; Text[30])
        {
            Caption = '1st sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "1st sort level") then begin
                    "Sort 1 : start pos." := 1;
                    "Sort 1 : length" := Critere.Length;
                end else begin
                    "Sort 1 : start pos." := 0;
                    "Sort 1 : length" := 0;
                    "Sort 1 : skip page" := false;
                end;
            end;
        }
        field(11; "Sort 1 : start pos."; Integer)
        {
            Caption = 'Sort 1 : start pos.';
        }
        field(12; "Sort 1 : length"; Integer)
        {
            Caption = 'Sort 1 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "1st sort level") and ("Sort 1 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(13; "Sort 1 : skip page"; Boolean)
        {
            Caption = 'Sort 1 : skip page';
        }
        field(14; "Sort 1 : line before total"; Option)
        {
            Caption = 'Sort 1 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(15; "Sort 1 : line after total"; Option)
        {
            Caption = 'Sort 1 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(20; "2nd sort level"; Text[30])
        {
            Caption = '2nd sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "2nd sort level") then begin
                    "Sort 2 : start pos." := 1;
                    "Sort 2 : length" := Critere.Length;
                end else begin
                    "Sort 2 : start pos." := 0;
                    "Sort 2 : length" := 0;
                    "Sort 2 : skip page" := false;
                end;
            end;
        }
        field(21; "Sort 2 : start pos."; Integer)
        {
            Caption = 'Sort 2 : start pos.';
        }
        field(22; "Sort 2 : length"; Integer)
        {
            Caption = 'Sort 2 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "2nd sort level") and ("Sort 2 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(23; "Sort 2 : skip page"; Boolean)
        {
            Caption = 'Sort 2 : skip page';
        }
        field(24; "Sort 2 : line before total"; Option)
        {
            Caption = 'Sort 2 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(25; "Sort 2 : line after total"; Option)
        {
            Caption = 'Sort 2 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(30; "3rd sort level"; Text[30])
        {
            Caption = '3rd sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "3rd sort level") then begin
                    "Sort 3 : start pos." := 1;
                    "Sort 3 : length" := Critere.Length;
                end else begin
                    "Sort 3 : start pos." := 0;
                    "Sort 3 : length" := 0;
                    "Sort 3 : skip page" := false;
                end;
            end;
        }
        field(31; "Sort 3 : start pos."; Integer)
        {
            Caption = 'Sort 3 : start pos.';
        }
        field(32; "Sort 3 : length"; Integer)
        {
            Caption = 'Sort 3 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "3rd sort level") and ("Sort 3 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(33; "Sort 3 : skip page"; Boolean)
        {
            Caption = 'Sort 3 : skip page';
        }
        field(34; "Sort 3 : line before total"; Option)
        {
            Caption = 'Sort 3 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(35; "Sort 3 : line after total"; Option)
        {
            Caption = 'Sort 3 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(40; "4th sort level"; Text[30])
        {
            Caption = '4th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "4th sort level") then begin
                    "Sort 4 : start pos." := 1;
                    "Sort 4 : length" := Critere.Length;
                end else begin
                    "Sort 4 : start pos." := 0;
                    "Sort 4 : length" := 0;
                    "Sort 4 : skip page" := false;
                end;
            end;
        }
        field(41; "Sort 4 : start pos."; Integer)
        {
            Caption = 'Sort 4 : start pos.';
        }
        field(42; "Sort 4 : length"; Integer)
        {
            Caption = 'Sort 4 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "4th sort level") and ("Sort 4 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(43; "Sort 4 : skip page"; Boolean)
        {
            Caption = 'Sort 4 : skip page';
        }
        field(44; "Sort 4 : line before total"; Option)
        {
            Caption = 'Sort 4 :';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(45; "Sort 4 : line after total"; Option)
        {
            Caption = 'Sort 4 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(50; "5th sort level"; Text[30])
        {
            Caption = '5th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "5th sort level") then begin
                    "Sort 5 : start pos." := 1;
                    "Sort 5 : length" := Critere.Length;
                end else begin
                    "Sort 5 : start pos." := 0;
                    "Sort 5 : length" := 0;
                    "Sort 5 : skip page" := false;
                end;
            end;
        }
        field(51; "Sort 5 : start pos."; Integer)
        {
            Caption = 'Sort 5 : start pos.';
        }
        field(52; "Sort 5 : length"; Integer)
        {
            Caption = 'Sort 5 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "5th sort level") and ("Sort 5 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(53; "Sort 5 : skip page"; Boolean)
        {
            Caption = 'Sort 5 : skip page';
        }
        field(54; "Sort 5 : line before total"; Option)
        {
            Caption = 'Sort 5 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(55; "Sort 5 : line after total"; Option)
        {
            Caption = 'Sort 5 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(60; "6th sort level"; Text[30])
        {
            Caption = '6th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "6th sort level") then begin
                    "Sort 6 : start pos." := 1;
                    "Sort 6 : length" := Critere.Length;
                end else begin
                    "Sort 6 : start pos." := 0;
                    "Sort 6 : length" := 0;
                    "Sort 6 : skip page" := false;
                end;
            end;
        }
        field(61; "Sort 6 : start pos."; Integer)
        {
            Caption = 'Sort 6 : start pos.';
        }
        field(62; "Sort 6 : length"; Integer)
        {
            Caption = 'Sort 6 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "6th sort level") and ("Sort 6 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(63; "Sort 6 : skip page"; Boolean)
        {
            Caption = 'Sort 6 : skip page';
        }
        field(64; "Sort 6 : line before total"; Option)
        {
            Caption = 'Sort 6 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(65; "Sort 6 : line after total"; Option)
        {
            Caption = 'Sort 6 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(70; "7th sort level"; Text[30])
        {
            Caption = '7th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "7th sort level") then begin
                    "Sort 7 : start pos." := 1;
                    "Sort 7 : length" := Critere.Length;
                end else begin
                    "Sort 7 : start pos." := 0;
                    "Sort 7 : length" := 0;
                    "Sort 7 : skip page" := false;
                end;
            end;
        }
        field(71; "Sort 7 : start pos."; Integer)
        {
            Caption = 'Sort 7 : start pos.';
        }
        field(72; "Sort 7 : length"; Integer)
        {
            Caption = 'Sort 7 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "7th sort level") and ("Sort 7 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(73; "Sort 7 : skip page"; Boolean)
        {
            Caption = 'Sort 7 : skip page';
        }
        field(74; "Sort 7 : line before total"; Option)
        {
            Caption = 'Sort 7 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(75; "Sort 7 : line after total"; Option)
        {
            Caption = 'Sort 7 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(80; "8th sort level"; Text[30])
        {
            Caption = '8th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "8th sort level") then begin
                    "Sort 8 : start pos." := 1;
                    "Sort 8 : length" := Critere.Length;
                end else begin
                    "Sort 8 : start pos." := 0;
                    "Sort 8 : length" := 0;
                    "Sort 8 : skip page" := false;
                end;
            end;
        }
        field(81; "Sort 8 : start pos."; Integer)
        {
            Caption = 'Sort 8 : start pos.';
        }
        field(82; "Sort 8 : length"; Integer)
        {
            Caption = 'Sort 8 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "8th sort level") and ("Sort 8 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(83; "Sort 8 : skip page"; Boolean)
        {
            Caption = 'Sort 8 : skip page';
        }
        field(84; "Sort 8 : line before total"; Option)
        {
            Caption = 'Sort 8 :';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(85; "Sort 8 : line after total"; Option)
        {
            Caption = 'Sort 8 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(90; "9th sort level"; Text[30])
        {
            Caption = '9th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "9th sort level") then begin
                    "Sort 9 : start pos." := 1;
                    "Sort 9 : length" := Critere.Length;
                end else begin
                    "Sort 9 : start pos." := 0;
                    "Sort 9 : length" := 0;
                    "Sort 9 : skip page" := false;
                end;
            end;
        }
        field(91; "Sort 9 : start pos."; Integer)
        {
            Caption = 'Sort 9 : start pos.';
        }
        field(92; "Sort 9 : length"; Integer)
        {
            Caption = 'Sort 9 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "9th sort level") and ("Sort 9 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(93; "Sort 9 : skip page"; Boolean)
        {
            Caption = 'Sort 9 : skip page';
        }
        field(94; "Sort 9 : line before total"; Option)
        {
            Caption = 'Sort 9 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(95; "Sort 9 : line after total"; Option)
        {
            Caption = 'Sort 9 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(100; "10th sort level"; Text[30])
        {
            Caption = '10th sort level';
            TableRelation = "Statistic criteria"."Field name" where(Type = filter("Sort criteria"));

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "10th sort level") then begin
                    "Sort 10 : start pos." := 1;
                    "Sort 10 : length" := Critere.Length;
                end else begin
                    "Sort 10 : start pos." := 0;
                    "Sort 10 : length" := 0;
                    "Sort 10 : skip page" := false;
                end;
            end;
        }
        field(101; "Sort 10 : start pos."; Integer)
        {
            Caption = 'Sort 10 : start pos.';
        }
        field(102; "Sort 10 : length"; Integer)
        {
            Caption = 'Sort 10 : length';

            trigger OnValidate()
            begin
                if Critere.Get(Critere.Type::"Sort criteria", "10th sort level") and ("Sort 10 : length" > Critere.Length) then
                    Error(Error1, Critere.Length);
            end;
        }
        field(103; "Sort 10 : skip page"; Boolean)
        {
            Caption = 'Sort 10 : skip page';
        }
        field(104; "Sort 10 : line before total"; Option)
        {
            Caption = 'Sort 10 : line before total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
        field(105; "Sort 10 : line after total"; Option)
        {
            Caption = 'Sort 10 : line after total';
            OptionCaption = 'No,Hairline,1pt,2pt,3pt';
            OptionMembers = No,Hairline,"1pt","2pt","3pt";
        }
    }

    keys
    {
        key(Key1; Type, "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Critere: Record "Statistic criteria";
        Error1: label 'Max length is %1 character for this field';
}

