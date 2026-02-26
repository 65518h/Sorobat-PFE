page 50279 "Calcul Cout"
{
    PageType = Card;
    SourceTable = "Calcul Cout";
    SourceTableView = SORTING(Rubrique, "Element Calcul");

    layout
    {
        area(content)
        {
            repeater("Control1")
            {
                ShowCaption = false;
                field(Type; rec.Type)
                {
                }
                field(Rubrique; rec.Rubrique)
                {
                }
                field("Element Calcul"; rec."Element Calcul")
                {
                }
                field("Charge Direct"; rec."Charge Direct")
                {
                }
                field("% Charge Direct"; rec."% Charge Direct")
                {
                    BlankZero = true;
                    DecimalPlaces = 0 : 2;
                }
                field(Dynamique; rec.Dynamique)
                {
                }
                field(Materiel; rec.Materiel)
                {
                }
                field(Mo; rec.Mo)
                {
                }
                field("Mo Attaché"; rec."Mo Attaché")
                {
                }
                field(Produit; rec.Produit)
                {
                }
                field("Nombre Jours Etallonnage"; rec."Nombre Jours Etallonnage")
                {
                    BlankZero = true;
                }
                field(Cout; rec.Cout)
                {
                }
                field(Formule; rec.Formule)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(Unite; rec.Unite)
                {
                }
                field("Cout Journalier"; rec."Cout Journalier")
                {
                }
                field(Remarque; rec.Remarque)
                {
                }
            }
            field(CoutJournalier; CoutJournalier)
            {
                Caption = 'Cout Journalier';
                DecimalPlaces = 0 : 0;
                Editable = false;
                Style = Unfavorable;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Mise a Jour Cout")
            {
                Caption = 'Mise a Jour Cout';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CalculCoutCarriere(WORKDATE);
                    ProductionOrder.SETRANGE(Status, ProductionOrder.Status::Finished);
                    IF ProductionOrder.FINDFIRST THEN
                        REPEAT
                            IF ProductionOrder.Quantity <> 0 THEN
                                ProductionOrder.VALIDATE("Nombre Heure Travail", ProductionOrder."Nombre Heure Travail");
                            ProductionOrder.MODIFY;

                        UNTIL ProductionOrder.NEXT = 0;
                end;
            }
        }
    }

    var
        ProductionOrder: Record 5405;
        Text001: Label 'Tache Effectuér=e Avec Succée';
        ItemLedgerEntry: Record 32;
        Item: Record 27;
        CPR: Decimal;
        CoutDirect: Decimal;
        CoutJournalier: Decimal;


    procedure CalculCoutCarriere(ParaDateDebut: Date)
    var
        CalculCout: Record "Calcul Cout";
        Vehicule: Record Véhicule;
        CoutMateriel: Decimal;
        Employee: Record 5200;
        SalaryLinesEnreg: Record "Rec. Salary Lines";
        Annee: Integer;
        Mois: Integer;
        MasseSalariale: Decimal;
        Text001: Label 'Tache Effectuée Avec Succée';
    begin
        CoutDirect := 0;
        CalculCout.RESET;
        CalculCout.SETRANGE(Type, CalculCout.Type::Carriere);
        IF CalculCout.FINDFIRST THEN
            REPEAT
                IF (CalculCout.Materiel <> '') AND (CalculCout.Produit = '') AND (CalculCout.Dynamique) THEN BEGIN
                    CoutMateriel := Vehicule.CoutMaterielTransport(ParaDateDebut - CalculCout."Nombre Jours Etallonnage", ParaDateDebut,
                    CalculCout.Materiel, 0, 0, TRUE);
                    CalculCout.VALIDATE(Cout, CoutMateriel);

                END;
                IF CalculCout.Mo AND (CalculCout.Dynamique) THEN BEGIN
                    MasseSalariale := 0;
                    Annee := DATE2DMY(ParaDateDebut, 3);
                    Mois := DATE2DMY(ParaDateDebut, 2);
                    IF Mois = 1 THEN BEGIN
                        Annee := Annee - 1;
                        Mois := 12;
                    END;
                    Employee.SETRANGE("MO Attaché", CalculCout."Mo Attaché");
                    Employee.SETRANGE(Blocked, FALSE);
                    IF Employee.FINDFIRST THEN
                        REPEAT
                            SalaryLinesEnreg.SETRANGE(Employee, Employee."No.");
                            SalaryLinesEnreg.SETRANGE(Year, Annee);
                            SalaryLinesEnreg.SETRANGE(Month, Mois - 2);
                            IF SalaryLinesEnreg.FINDFIRST THEN
                                REPEAT
                                    MasseSalariale += SalaryLinesEnreg."Net salary cashed" * 1.2;
                                UNTIL SalaryLinesEnreg.NEXT = 0;
                        UNTIL Employee.NEXT = 0;
                    CalculCout.VALIDATE(Cout, MasseSalariale / 26);
                END;
                IF (CalculCout.Produit <> '') AND (CalculCout.Dynamique) THEN BEGIN
                    CPR := 0;
                    ItemLedgerEntry.SETCURRENTKEY("N° Véhicule", "Item No.", "Posting Date");
                    ItemLedgerEntry.SETRANGE("Posting Date", ParaDateDebut - CalculCout."Nombre Jours Etallonnage", ParaDateDebut);
                    ItemLedgerEntry.SETRANGE("Item No.", CalculCout.Produit);
                    ItemLedgerEntry.SETFILTER("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::"Negative Adjmt.",
                                              ItemLedgerEntry."Entry Type"::Sale);
                    IF ItemLedgerEntry.FINDFIRST THEN
                        REPEAT
                            IF Item.GET(ItemLedgerEntry."Item No.") THEN;
                            CPR += ABS(ItemLedgerEntry.Quantity) * Item."Last Direct Cost";
                        UNTIL ItemLedgerEntry.NEXT = 0;
                    IF CalculCout."Nombre Jours Etallonnage" = 0 THEN CalculCout."Nombre Jours Etallonnage" := 1;
                    CalculCout.VALIDATE(Cout, CPR / CalculCout."Nombre Jours Etallonnage");

                END;

                IF CalculCout."Charge Direct" THEN CoutDirect += CalculCout."Cout Journalier";

                CalculCout.MODIFY;
            UNTIL CalculCout.NEXT = 0;
        CalculCout.RESET;
        CalculCout.SETFILTER("% Charge Direct", '<>%1', 0);
        IF CalculCout.FINDFIRST THEN
            REPEAT
                CalculCout.VALIDATE(Cout, ROUND(CoutDirect * CalculCout."% Charge Direct" / 100, 1));
                CalculCout.MODIFY;
            UNTIL CalculCout.NEXT = 0;
        CoutJournalier := 0;
        CalculCout.RESET;
        IF CalculCout.FINDFIRST THEN
            REPEAT
                CoutJournalier += CalculCout."Cout Journalier";
            UNTIL CalculCout.NEXT = 0;
        MESSAGE(Text001);
    end;
}

