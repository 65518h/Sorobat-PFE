Table 52049077 "Ligne Pointage Salarier Man"
{

    fields
    {
        field(1; "N°"; Code[20])
        {
        }
        field(2; Matricule; Code[10])
        {
            /*SQLDataType = Varchar;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin

                GRecSalary.Reset;
                if GRecSalary.Get(Matricule) then begin
                    GRecSalary.CalcFields("Deccription Affectation");
                    GRecSalary.CalcFields("Description Qualification");
                    Nom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
                    Affectation := GRecSalary.Affectation;
                    Qualification := GRecSalary.Qualification;
                    "Description Affectation" := GRecSalary."Deccription Affectation";
                    "Description Qualification" := GRecSalary."Description Qualification";

                end;
                Insert();
            end;*/
            SQLDataType = Varchar;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if GRecSalary.Get(Matricule) then begin
                    GRecSalary.CalcFields(
                        "Deccription Affectation",
                        "Description Qualification"
                    );

                    Nom := GRecSalary."First Name" + ' ' + GRecSalary."Last Name";
                    Affectation := GRecSalary.Affectation;
                    Qualification := GRecSalary.Qualification;
                    "Description Affectation" := GRecSalary."Deccription Affectation";
                    "Description Qualification" := GRecSalary."Description Qualification";
                end else begin
                    Clear(Nom);
                    Clear(Affectation);
                    Clear(Qualification);
                    Clear("Description Affectation");
                    Clear("Description Qualification");
                end;
            end;

        }
        field(3; Nom; Text[150])
        {
        }
        field(4; Affectation; Code[20])
        {
        }
        field(5; Qualification; Code[20])
        {
        }
        field(6; "Description Affectation"; Text[150])
        {
        }
        field(7; "Description Qualification"; Text[150])
        {
        }

        field(8; "1"; Code[5]) 
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(9; "2"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(10; "3"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(11; "4"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(12; "5"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(13; "6"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(14; "7"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(15; "8"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(16; "9"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(17; "10"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(18; "11"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(19; "12"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(20; "13"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(21; "14"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(22; "15"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(23; "16"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(24; "17"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(25; "18"; Code[5])
        {
            trigger OnValidate() begin CalculateTotals(); end;

        }
        field(26; "19"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;

        }
        field(27; "20"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(28; "21"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(29; "22"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(30; "23"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(31; "24"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(32; "25"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(33; "26"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(34; "27"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(35; "28"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(36; "29"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(37; "30"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(38; "31"; Code[20])
        {
            trigger OnValidate() begin CalculateTotals(); end;
        }
        field(39; "Nbre Jours Present"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(40; "Nbre Jours Absent"; Integer)
        {
        }
        field(41; "Nbre Total Heures Presnt"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(42; "Taux d'absenteisme"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(43; "Nbre Jours Ferier"; Integer)
        {
        }
        field(44; "Nbre Jours Congé"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(45; "Nbre Jours Congé EXP"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; "N°", Matricule)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    var

        GRecSalary: Record Employee;

    procedure CalculateTotals()
    var
        RecRef: RecordRef;
        FldRef: FieldRef;
        i: Integer;
        Val: Code[20];
    begin
        // Remise à zéro de tous les compteurs
        "Nbre Jours Present"    := 0;
        "Nbre Jours Absent"     := 0;
        "Nbre Total Heures Presnt" := 0;
        "Nbre Jours Ferier"     := 0;
        "Nbre Jours Congé"      := 0;
        "Nbre Jours Congé EXP"  := 0;

        RecRef.GetTable(Rec);

        // Boucle sur les field index 8 à 38 (jours 1 à 31)
        for i := 8 to 38 do begin
            FldRef := RecRef.Field(i);
            Val := UpperCase(DelChr(Format(FldRef.Value), '=', ' '));

            case Val of
                'P':
                    // Présent plein jour
                    "Nbre Jours Present" += 1;
                'A':
                    // Absent
                    "Nbre Jours Absent" += 1;
                'F':
                    // Férié
                    "Nbre Jours Ferier" += 1;
                'C':
                    // Congé plein jour
                    "Nbre Jours Congé" += 1;
                'CEXP':
                    // Congé exceptionnel plein jour
                    "Nbre Jours Congé EXP" += 1;
                'C1/2':
                    begin
                        // Demi-journée : 0.5 présent + 0.5 congé
                        "Nbre Jours Present" += 0.5;
                        "Nbre Jours Congé"   += 0.5;
                    end;
            end;
        end;

        // Total heures : 8h par jour présent (y compris les demi-journées)
        "Nbre Total Heures Presnt" := "Nbre Jours Present" * 8;
    end;


}

