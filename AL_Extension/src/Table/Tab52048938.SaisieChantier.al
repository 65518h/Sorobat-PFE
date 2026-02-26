
Table 52048938 "Saisie Chantier"
{
    //GL2024  ID dans Nav 2009 : "39001455"
    fields
    {
        field(1; Sequence; Integer)
        {
        }
        field(2; Date; Date)
        {

            trigger OnValidate()
            begin
                ParamRsh.Get;
                if Date2dmy(Date, 1) > ParamRsh."Date de Calcul de Paie" then begin
                    if Date2dmy(Date, 2) = 12 then begin
                        month := 0;
                        year := Date2dmy(Date, 3) + 1;
                    end
                    else begin
                        month := Date2dmy(Date, 2);
                        year := Date2dmy(Date, 3);
                    end;
                end else begin
                    month := Date2dmy(Date, 2) - 1;
                    year := Date2dmy(Date, 3);
                end;
                ChantEng.Reset;
                ChantEng.SetCurrentkey(Employee, Date);
                ChantEng.SetFilter(Employee, Employee);
                ChantEng.SetRange(Date, Date);
                if ChantEng.Find('-') then
                    Error('Vous Avez déjà saisie L''employee %1 dans le chantier %2 !!!', ChantEng.Employee, ChantEng.Chantier);
            end;
        }
        field(3; Chantier; Code[20])
        {
            TableRelation = Chantier."Code Chantier" WHERE(Blocked = FILTER(false));
        }
        field(4; Employee; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Clear(T1);
                if T1.Get(Employee) then
                    Name := T1."Last Name" + ' ' + T1."First Name"
                else
                    Name := '';
            end;
        }
        field(10; month; Option)
        {
            Caption = 'Posting month';
            OptionCaption = 'January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = January," February"," March"," April"," May"," June"," July"," August"," September"," October"," November"," December";
        }
        field(11; year; Integer)
        {
            Caption = 'Posting year';
        }
        field(12; Shift; Option)
        {
            OptionMembers = " ","Day Shift","Night Shift";
        }
        field(15; Name; Text[100])
        {
        }
        field(30; "Jours du transport"; Boolean)
        {
        }
        field(31; "Ind. Supp Chantier"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Sequence)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ParamRsh: Record "Human Resources Setup";
        T1: Record Employee;
        ChantEng: Record "Chantier Enreg.";
}

