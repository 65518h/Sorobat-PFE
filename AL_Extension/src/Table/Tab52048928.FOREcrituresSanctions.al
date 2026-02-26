table 52048928 "FOR-Ecritures Sanctions"
{//GL2024  ID dans Nav 2009 : "39001479"
 //GL2024  DrillDownPageID = Form70096;
 //GL2024   LookupPageID = Form70096;

    fields
    {
        field(1; "N° Sequences"; Integer)
        {
            Caption = 'N° Séquences';
        }
        field(2; "Code Motif"; Code[20])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; "Code Note"; Code[20])
        {
        }
        field(5; "Nombre Fois"; Integer)
        {
            Caption = 'Nombre de fois';
        }
        field(6; Annee; Integer)
        {
            Caption = 'Année';
        }
        field(7; Trimestre; Integer)
        {
        }
        field(8; Mois; Integer)
        {
        }
        field(9; "Points Sanctionees"; Decimal)
        {
            Caption = 'Points sanctionées';
        }
        field(10; Taux; Decimal)
        {
        }
        field(11; "Employee No."; Code[20])
        {
            Caption = 'N° Salarié';
            TableRelation = Employee;
        }
        field(12; "Note Encour"; Decimal)
        {
            /*  CalcFormula = Average(Table70049.Field9 WHERE(Field4 = FIELD(Code Note),
                                                             Field6=FIELD(Annee),
                                                             Field8=FIELD(Mois),
                                                             Field11=FIELD(Employee No.),
                                                             Field20=FIELD(Periode)));
              FieldClass = FlowField;*/
        }
        field(13; "Total Points"; Decimal)
        {
            /*   CalcFormula = Sum(Table70049.Field9 WHERE (Field4=FIELD(Code Note),
                                                          Field6=FIELD(Annee),
                                                          Field7=FIELD(Trimestre),
                                                          Field11=FIELD(Employee No.),
                                                          Field20=FIELD(Periode)));
               FieldClass = FlowField;*/
        }
        field(14; "Filtre code Note"; Code[20])
        {
        }
        field(15; "Filtre Annee"; Integer)
        {
        }
        field(16; "Filtre Trimestre"; Integer)
        {
        }
        field(17; "Filtre Mois"; Integer)
        {
        }
        field(18; "Filtre Salarie"; Code[20])
        {
        }
        field(19; "Filtre Date"; Date)
        {
        }
        field(20; Periode; Integer)
        {
            Caption = 'Période';
        }
        field(21; "Filtre Periode"; Integer)
        {
            Caption = 'Filtre Période';
            FieldClass = FlowFilter;
        }
        field(22; User; Code[20])
        {
        }
        field(50102; "Filtre Societe"; Option)
        {
            //CalcFormula = Lookup(Employee.Field50102 WHERE (No.=FIELD(Employee No.)));
            Caption = 'Filter Société';
            Description = 'GRH-TRIUM1.00';
            //FieldClass = FlowField;
            OptionMembers = " ",INTERMETAL,"RADES SERVICE","MEGRINE SERVICE";
        }
        field(50103; Periodicite; DateFormula)
        {
            Caption = 'Périodicité';
        }
    }

    keys
    {
        key(Key1; "N° Sequences", "Code Note")
        {
            Clustered = true;
        }
        key(Key2; "Code Note", Annee, Trimestre, Mois, "Employee No.", Date, Periode)
        {
            SumIndexFields = "Points Sanctionees";
        }
        key(Key3; "Employee No.", "Code Motif", Annee, Trimestre, Mois, Date)
        {
            SumIndexFields = "Points Sanctionees";
        }
        key(Key4; "Filtre code Note", "Filtre Annee", "Filtre Trimestre", "Filtre Salarie", "Filtre Date")
        {
            SumIndexFields = "Points Sanctionees";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecLEcritureSanctions: Record 52048928;
    begin
        /*IF RecLEcritureSanctions.FINDLAST THEN
          "N° Sequences":=RecLEcritureSanctions."N° Sequences"+1
        ELSE
          "N° Sequences":=1;*/

    end;


    procedure CalculerNote(CodeNote: Code[20]): Decimal
    var
        RecLParamGRH: Record 5218;
        RecLSetupNotes: Record 52048927;
    begin
        RecLParamGRH.GET;
        CALCFIELDS("Total Points");
        RecLSetupNotes.GET(CodeNote);
        EXIT(RecLSetupNotes."Echele Notation" + "Total Points");
    end;
}

