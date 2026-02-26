TableExtension 50151 "Production OrderEXT" extends "Production Order"
{
    fields
    {
        modify("Source No.")
        {
            TableRelation = if ("Source Type" = const(Item)) Item where("Replenishment System" = const("Prod. Order"))
            else
            if ("Source Type" = const(Family)) Family
            else
            if (Status = const(Simulated),
                                     "Source Type" = const("Sales Header")) "Sales Header"."No." where("Document Type" = const(Quote))
            else
            if (Status = filter(Planned ..),
                                              "Source Type" = const("Sales Header")) "Sales Header"."No." where("Document Type" = const(Order));
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CoutM3;
            end;
        }

        field(50000; Centrale; Code[20])
        {
            Description = 'HJ SORO 20-08-2015';
            TableRelation = Location;

            trigger OnValidate()
            begin
                Validate("Location Code", Centrale);
            end;
        }
        field(50001; "N° BL"; Code[20])
        {
            Description = 'HJ SORO 20-08-2015';

            trigger OnValidate()
            begin
                ProdOrder2.SetRange("N° BL", "N° BL");
                if ProdOrder2.Count > 1 then Error(Text010);
            end;
        }
        field(50002; Destination; Text[100])
        {
            Description = 'HJ SORO 20-08-2015';
            TableRelation = "Sous Affectation Marche";
            trigger onvalidate()
            BEGIN
                SousAffectationMarche.SETRANGE(Code, Destination);
                IF SousAffectationMarche.FINDFIRST THEN IF SousAffectationMarche.Stockable THEN Stockable := TRUE;
            END;
        }
        field(50003; Stockable; Boolean)
        {
            Description = 'HJ SORO 18-04-2016';
            Editable = false;
        }
        field(50004; "Largeur Impregnation (M)"; Integer)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Validate(Quantity, "Largeur Impregnation (M)" * "Longueur  Impregnation (M)" * 1000);
            end;
        }
        field(50005; "Longueur  Impregnation (M)"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Validate(Quantity, "Largeur Impregnation (M)" * "Longueur  Impregnation (M)" * 1000);
            end;
        }
        field(50006; "Largeur Tri Couche (M)"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Validate(Quantity, "Largeur Impregnation (M)" * "Longueur  Impregnation (M)" * 1000);
            end;
        }
        field(50007; "Largeur Monocouche (M)"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Validate(Quantity, "Largeur Impregnation (M)" * "Longueur  Impregnation (M)" * 1000);
            end;
        }
        field(50008; "Longueur  Tricouche (M)"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Validate(Quantity, "Largeur Impregnation (M)" * "Longueur  Impregnation (M)" * 1000);
            end;
        }
        field(50009; "Longueur  Monocouche (M)"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                Validate(Quantity, "Largeur Impregnation (M)" * "Longueur  Impregnation (M)" * 1000);
            end;
        }
        field(50010; Camion; Code[20])
        {
            Description = 'HJ SORO 18-04-2016';
            TableRelation = Véhicule;
        }
        field(50011; Chauffeur; Code[50])
        {
            Description = 'HJ SORO 18-04-2016';
            TableRelation = "Shipping Agent";
        }
        field(50012; "Nombre Heure Travail"; Decimal)
        {
            Description = 'HJ SORO 18-04-2016';

            trigger OnValidate()
            begin
                CoutM3;
            end;
        }
        field(50013; "Nombre Voyage"; Integer)
        {
            Description = 'HJ SORO 18-08-2016';
        }
        field(50014; "Cout M3"; Decimal)
        {
            Description = 'HJ SORO 18-08-2016';
            Editable = false;
        }
        field(50015; Observation; Text[250])
        {
            Description = 'HJ SORO 18-08-2016';
        }
        field(50016; Client; Code[20])
        {
            TableRelation = Job;
        }
        field(50017; "Controlé"; Boolean)
        {
            Description = 'HJ SORO 11-01-2018';
        }
        field(50018; Selectionner; Boolean)
        {
            Description = 'MH SORO 27-02-2018';
        }
        field(50019; "Integrer BL"; Boolean)
        {
            Description = 'MH SORO 27-02-2018';
        }
        field(50020; "Code Commande Vente"; Code[20])
        {
            Description = 'MH SORO 27-02-2018';
        }
        /*  field(50021; "Client Nav"; Code[20])
          {
              CalcFormula = lookup(Job."Correspandant Client" where("No." = field(Client)));
              Description = 'MH SORO 27-02-2018';
              FieldClass = FlowField;
          }*/
        field(50022; "Client Nav 2"; Code[20])
        {
            Description = 'MH SORO 27-02-2018';
            TableRelation = Customer;
        }
        field(50023; Automate; Boolean)
        {
            Description = 'HJ SORO 25-06-2018';
        }
        field(50024; Service; Code[100])
        {
        }
    }
    keys
    {

        key(Key9; "Due Date")
        {
        }
    }



    procedure CoutM3()
    var
        RecCoutJournalier: Record "Calcul Cout";
        CoutJour: Decimal;
    begin
        CoutJour := 0;
        // RecCoutJournalier.SETRANGE(Type, RecCoutJournalier.Type::0);
        RecCoutJournalier.SETRANGE(Type, RecCoutJournalier.Type::Carriere);
        IF RecCoutJournalier.FINDFIRST THEN
            REPEAT
                IF (RecCoutJournalier.Materiel <> '') AND (RecCoutJournalier.Produit = '') THEN BEGIN

                END;
                CoutJour += RecCoutJournalier."Cout Journalier";
            UNTIL RecCoutJournalier.NEXT = 0;

        "Cout M3" := (CoutJour / Quantity) * ("Nombre Heure Travail" / 8);


    end;

    var
        "// HJ": Integer;
        ProdOrder2: Record "Production Order";
        Text010: label 'N° BL Déja Saisie';
        ProductionBOMHeader: Record "Production BOM Header";
        SousAffectationMarche: Record "Sous Affectation Marche";
}

