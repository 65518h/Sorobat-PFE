Table 52049076 "Entete Pointage Salarier Man"
{
    //  LookupPageID = "Liste Pointage Employée";
    //GL2024  ID dans Nav 2009 : "39001536"
    fields
    {
        field(1; "N°"; Code[20])
        {
        }

        field(2; Mois; Option)
        {
            OptionCaption = ' ,Janvier,Février,Mars,Avril,Mai,Juin,Juillet,Août,Septembre,Octobre,Novembre,Décembre';
            OptionMembers = " ",Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,"Août",Septembre,Octobre,Novembre,"Décembre";
            trigger OnValidate()
            var

            begin

                RecEntetePointage.RESET;
                RecEntetePointage.SETRANGE(Chantier, Chantier);
                RecEntetePointage.SETRANGE(Mois, Mois);
                RecEntetePointage.SETRANGE("Année", "Année");
                IF RecEntetePointage.FINDFIRST THEN ERROR(Text001, Chantier, Mois, "Année");
            end;
        }
        field(3; "Année"; Integer)
        {
            trigger OnValidate()
            var

            begin

                RecEntetePointage.RESET;
                RecEntetePointage.SETRANGE(Chantier, Chantier);
                RecEntetePointage.SETRANGE(Mois, Mois);
                RecEntetePointage.SETRANGE("Année", "Année");
                IF RecEntetePointage.FINDFIRST THEN ERROR(Text001, Chantier, Mois, "Année");
            end;

        }

        field(4; Chantier; Code[20])
        {
            TableRelation = Job;

            trigger OnValidate()
            var

            begin

                RecEntetePointage.RESET;
                RecEntetePointage.SETRANGE(Chantier, Chantier);
                RecEntetePointage.SETRANGE(Mois, Mois);
                RecEntetePointage.SETRANGE("Année", "Année");
                IF RecEntetePointage.FINDFIRST THEN ERROR(Text001, Chantier, Mois, "Année");
            end;
        }

        field(5; "Total Effectif"; Integer)
        {
            CalcFormula = count("Ligne Pointage Salarier Man" where("N°" = field("N°")));
            FieldClass = FlowField;

        }
        field(6; "Total Present"; Integer)
        {
            CalcFormula = sum("Ligne Recap Pointage Chantier"."Total Present" where("N°" = field("N°")));
            FieldClass = FlowField;
        }
        field(7; "Taux Present"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(8; "Total Absent Justifie"; Integer)
        {
            CalcFormula = sum("Ligne Recap Pointage Chantier"."Total Absent Justifie" where("N°" = field("N°")));
            FieldClass = FlowField;
        }
        field(9; "Taux Absent Justifié"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(10; "Total Absence"; Integer)
        {
            CalcFormula = sum("Ligne Recap Pointage Chantier"."Total Absence" where("N°" = field("N°")));
            FieldClass = FlowField;
        }
        field(11; "Taux Absence"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
        field(12; "Seuil Jours de Pointage"; Integer)
        {

        }
        field(13; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
            Editable = false;
        }
        /*field(3; Chantier; Code[20])
        {
            TableRelation = Job;
        }
        field(4; Utilisateur; Code[20])
        {
        }
        field(5; "Validé"; Boolean)
        {
        }
        field(6; "Nbre Effectif"; Integer)
        {
            CalcFormula = count("Ligne Pointage Employé" where("N°" = field("N°"),
                                                                Present = filter(> 0)));
            FieldClass = FlowField;
        }*/
    }

    keys
    {
        key(Key1; "N°")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        if "N°" = '' then begin
            NoSeriesMgt.InitSeries(
                PointageNoSeriesCode,   // Code de la série : 'PSAL-PMANU'
                "No. Series",
                0D,
                "N°",
                "No. Series"
            );
        end;
    end;

    trigger OnDelete()
    var
        LignePointage: Record "Ligne Pointage Salarier Man";
    begin
        // Supprimer les lignes liées à cet en-tête
        LignePointage.SetRange("N°", "N°");
        LignePointage.DeleteAll(true);
    end;

    var
        RecEntetePointage: Record "Entete Pointage Salarier Man";
        Text001: Label 'Information Deja saisie Pour La Journée du Pointage du chantier: %1 , Mois %2 , Année %3';
        PointageNoSeriesCode: Label 'PSAL-PMANU', Locked = true;



}

