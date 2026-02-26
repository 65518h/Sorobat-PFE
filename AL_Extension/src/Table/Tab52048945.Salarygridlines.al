table 52048945 "Salary grid lines"
{
    //GL2024  ID dans Nav 2009 : "39001421"
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            Editable = false;
            TableRelation = "Salary grid header";
        }
        field(2; "N° sequence"; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(3; "Collège"; Code[20])
        {
            Caption = 'Collège';
            Editable = true;
            TableRelation = CATEGORIES;
        }
        field(4; Grade; Integer)
        {
            Caption = 'Grade';

            trigger OnValidate()
            begin
                CLEAR(Col);
                IF NOT Col.GET(Collège) THEN
                    ERROR('Collège inexistant !!!');
                IF (Grade > Col."Borne Supérieure") OR (Grade < Col."Borne inférieure") THEN
                    ERROR('Grade Doit être entre %1 et %2, Merci', Col."Borne Supérieure", Col."Borne inférieure");
            end;
        }
        field(5; Echelle; Integer)
        {
            Caption = 'Echelle';
            TableRelation = Echelle.Echelle WHERE(Catégorie = FIELD(Collège));
        }
        field(6; Classe; Option)
        {
            OptionMembers = " ",A,B,C;
        }
        field(7; Echelon; Integer)
        {
            TableRelation = "Baréme De Charge"."Nombre De Charge";
        }
        field(10; "Basis salary"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Basis salary';
            DecimalPlaces = 3 : 3;
        }
        field(15; "Date fomula"; DateFormula)
        {
            Caption = 'Date fomula';
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
    }

    keys
    {
        key(Key1; "N° sequence")
        {
            Clustered = true;
        }
        key(Key2; "Code", "Collège", Grade, Echelle, Classe, Echelon)
        {
            SumIndexFields = "Basis salary";
        }
        key(Key3; "Code", Grade)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        Ech: Record "Baréme De Charge";
    begin
        "User ID" := USERID;
        "Last Date Modified" := WORKDATE;
        Ech.RESET;
        IF Ech.GET(Echelon) THEN
            "Date fomula" := Ech."Date fomula";
    end;

    var
        Col: Record CATEGORIES;
}

