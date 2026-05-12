page 50047 "Entete Fiche Gasoil"
{
    SourceTable = "Entete Fiche Gasoil";
    SourceTableView = WHERE(Statut = CONST("En Cours"));
    PageType = Card;

    Caption = 'Fiche Gasoil';


    layout
    {
        area(content)
        {
            group("FICHE DE STOCK DE GASOIL")
            {
                Caption = 'FICHE DE STOCK DE GASOIL';
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Cuve"; rec.Cuve)
                {
                    ApplicationArea = all;
                    Style = Strong;
                    Editable = true;
                    StyleExpr = true;


                    trigger OnValidate()
                    begin
                        IntIndexDebut := 0;
                        rec.Journee := TODAY;
                        IF RecInventorySetup.GET THEN;
                        rec."Article Gasoil" := RecInventorySetup."Article Gasoil";
                        rec.Utilisateur := USERID;
                        RecItem.SETFILTER("Location Filter", rec.Cuve);
                        RecItem.SETRANGE("No.", rec."Article Gasoil");
                        IF RecItem.FINDFIRST THEN BEGIN
                            RecItem.CALCFIELDS(Inventory);
                            rec."Index Depart" := RecItem.Inventory;
                        END;
                        ;
                    end;
                }
                field(Chantier; Rec.Chantier)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Journee"; rec.Journee)
                {
                    ApplicationArea = all;

                }
                field("Libelle Journée"; FORMAT(rec.Journee, 0, '<Weekday Text> <Day> <Month Text> 20<Year> '))
                {
                    ApplicationArea = all;
                    Caption = 'Libelle Journée';
                    Style = AttentionAccent;
                    StyleExpr = true;
                }

                field("Index Depart"; rec."Index Depart")
                {
                    ApplicationArea = all;
                    Caption = 'Index Depart';
                    Style = Subordinate;
                    StyleExpr = true;

                }
                field("Index Final"; rec."Index Final")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = true;

                }
                field("Statut"; rec.Statut)
                {
                    ApplicationArea = all;
                    Style = AttentionAccent;
                    StyleExpr = true;
                    Editable = false;

                }
                field("N° Fiche"; rec."N° Fiche")
                {
                    ApplicationArea = all;

                }
                // field("Index Pompe"; rec."Index Pompe")
                // {
                //     ApplicationArea = all;


                // }



            }
            part("Ligne Fiche Gasoil"; "Ligne Fiche Gasoil")
            {
                // GL2026  Editable = SubGasoilEDITABLE;
                ApplicationArea = all;
                Caption = 'Ligne Fiche Gasoil';//
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {

        area(creation)
        {
            group("Fonction")
            {
                Caption = 'Fonction';
                action(Valider)
                {
                    ApplicationArea = all;
                    Caption = 'Valider';
                    ShortCutKey = 'F11';
                    Image = Post;

                    trigger OnAction()
                    begin
                        IF rec.Statut = rec.Statut::Valider THEN EXIT;
                        IF NOT CONFIRM(Text001) THEN EXIT;
                        IF RecInventorySetup.GET THEN;
                        IF RecUserSetup.GET THEN;
                        IF RecItem.GET(rec."Article Gasoil") THEN;
                        RecLigneFicheGasoil.RESET;
                        RecLigneFicheGasoil.SETRANGE("Document No.", rec."No.");
                        IF RecLigneFicheGasoil.FINDFIRST THEN
                            REPEAT
                                RecLigneFicheGasoil.TESTFIELD(Heure);
                                RecLigneFicheGasoil.TESTFIELD(Materiel);
                                RecLigneFicheGasoil.TESTFIELD("Quantité Gasoil");
                                RecLigneFicheGasoil.TESTFIELD(Chauffeur);
                                RecLigneFicheGasoil.TESTFIELD(Destination);
                                IF RecLigneFicheGasoil."Type Index" = RecLigneFicheGasoil."Type Index"::Horaire THEN
                                    RecLigneFicheGasoil.TESTFIELD("Index Horaire");
                                IF RecLigneFicheGasoil."Type Index" = RecLigneFicheGasoil."Type Index"::Kilometrage THEN
                                    RecLigneFicheGasoil.TESTFIELD("Index Kilometrique");
                                RecLigneFicheGasoil.TESTFIELD(Affaire);
                            UNTIL RecLigneFicheGasoil.NEXT = 0;
                        IF RecItemJournalTemplate.GET(RecInventorySetup."Model Feuille Article") THEN;
                        CdeNumDoc := CduNoSeriesRespCentManagement.GetNextNo(RecItemJournalTemplate."No. Series",
                                                     rec.Journee, FALSE, RecUserSetup."Inventory Resp. Ctr. Filter");
                        RecItemJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Feuille Article");
                        RecItemJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model Par Defaut");
                        //RecItemJournalLine.SETRANGE(Utilisateur,USERID);
                        RecItemJournalLine.DELETEALL;
                        RecLigneFicheGasoil.RESET;
                        RecLigneFicheGasoil.SETRANGE("Document No.", rec."No.");
                        IF RecLigneFicheGasoil.FINDFIRST THEN
                            REPEAT
                                IntNumLigne += 10000;
                                RecItemJournalLine."Journal Template Name" := RecInventorySetup."Model Feuille Article";
                                RecItemJournalLine."Journal Batch Name" := RecInventorySetup."Nom Model Par Defaut";
                                RecItemJournalLine."Line No." := IntNumLigne;
                                RecItemJournalLine.VALIDATE("Item No.", rec."Article Gasoil");
                                RecItemJournalLine.VALIDATE("Posting Date", rec.Journee);
                                RecItemJournalLine."Entry Type" := RecItemJournalLine."Entry Type"::"Negative Adjmt.";
                                RecItemJournalLine."Document No." := CdeNumDoc;
                                RecItemJournalLine.VALIDATE(Quantity, RecLigneFicheGasoil."Quantité Gasoil");
                                RecItemJournalLine.VALIDATE("Location Code", rec.Cuve);
                                RecItemJournalLine."Type Index" := RecLigneFicheGasoil."Type Index";
                                RecItemJournalLine.Description := STRSUBSTNO(Text003, rec."N° Fiche");
                                RecItemJournalLine.Materiel := RecLigneFicheGasoil.Materiel;
                                RecItemJournalLine."N° Materiel" := RecLigneFicheGasoil.Materiel;
                                RecItemJournalLine.Marche := RecLigneFicheGasoil.Affaire;
                                RecItemJournalLine."Job No." := RecLigneFicheGasoil.Affaire;
                                RecItemJournalLine.Utilisateur := USERID;
                                ;
                                RecItemJournalLine.Heure := RecLigneFicheGasoil.Heure;
                                RecItemJournalLine.Chauffeur := RecLigneFicheGasoil.Chauffeur;
                                RecItemJournalLine.Destination := RecLigneFicheGasoil.Destination;
                                RecItemJournalLine."Index Horaire" := RecLigneFicheGasoil."Index Horaire";
                                RecItemJournalLine."Index Kilometrique" := RecLigneFicheGasoil."Index Kilometrique";
                                RecItemJournalLine.Consommation := TRUE;
                                RecItemJournalLine."Gen. Prod. Posting Group" := RecItem."Gen. Prod. Posting Group";
                                RecItemJournalLine.INSERT;
                                RecItemJournalLine.Validate("Shortcut Dimension 2 Code", RecLigneFicheGasoil.Affaire);
                                RecItemJournalLine.Modify();
                                IntQteCumulé += RecLigneFicheGasoil."Quantité Gasoil";
                                // Partie Mission
                                IF RecPriseCarburantEnregistré.FINDLAST THEN IntSequence := RecPriseCarburantEnregistré.Sequence;
                                IF RecVéhicule.GET(RecLigneFicheGasoil.Materiel) THEN BEGIN
                                    ;
                                    RecVéhicule.CALCFIELDS("Kms Parcourus");
                                    RecMissionEnregistré."N° Mission" := 'FGASOIL' + FORMAT(RecLigneFicheGasoil."Numero Ligne");
                                    RecMissionEnregistré."Date document" := rec.Journee;
                                    RecMissionEnregistré."Date Mission" := rec.Journee;

                                    RecMissionEnregistré."Code Demandeur" := RecLigneFicheGasoil.Chauffeur;
                                    RecMissionEnregistré."N° Véhicule" := RecLigneFicheGasoil.Materiel;
                                    RecMissionEnregistré."N° Affaire" := RecLigneFicheGasoil.Affaire;
                                    RecMissionEnregistré."Index Cpt. Depart" := RecVéhicule."Kms Parcourus" + RecVéhicule."Index de Départ";
                                    IF RecLigneFicheGasoil."Index Horaire" <> 0 THEN
                                        RecMissionEnregistré."Index Cpt. Retour" := RecLigneFicheGasoil."Index Horaire"
                                    ELSE
                                        RecMissionEnregistré."Index Cpt. Retour" := RecLigneFicheGasoil."Index Kilometrique";
                                    RecMissionEnregistré."Km Parcourus" := RecLigneFicheGasoil."Index Kilometrique" - RecVéhicule."Index de Départ"
                                    - RecVéhicule."Kms Parcourus";
                                    IF RecMissionEnregistré.INSERT THEN;
                                    // Partie Mission
                                    RecPriseCarburantEnregistré.Sequence := IntSequence;
                                    RecPriseCarburantEnregistré."N° Véhicule" := RecLigneFicheGasoil.Materiel;
                                    RecPriseCarburantEnregistré."N° Mission" := 'FGASOIL' + FORMAT(RecLigneFicheGasoil."Numero Ligne");
                                    RecPriseCarburantEnregistré."Article Associé" := RecLigneFicheGasoil.Article;
                                    RecPriseCarburantEnregistré.VALIDATE("Date de Prise", rec.Journee);
                                    RecPriseCarburantEnregistré.VALIDATE("Gasoil Consommé", RecLigneFicheGasoil."Quantité Gasoil");
                                    ;
                                    IF RecPriseCarburantEnregistré.INSERT THEN;
                                    // Prise Carburant
                                END;
                                RecLigneFicheGasoil.Statut := RecLigneFicheGasoil.Statut::Valider;
                                RecLigneFicheGasoil.MODIFY;
                            UNTIL RecLigneFicheGasoil.NEXT = 0;
                        rec."Index Final" := rec."Index Depart" - IntQteCumulé;
                        rec.Statut := rec.Statut::Valider;
                        rec.MODIFY;
                        // >> HJ DSFT 27-03-2012
                        RecItemJournalLine.RESET;
                        RecItemJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Feuille Article");
                        RecItemJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model Par Defaut");
                        IF RecItemJournalTemplate.GET(RecInventorySetup."Model Feuille Article") THEN;
                        //IF RecItemJournalTemplate."Feuille Affectaion Charge" THEN
                        //  BEGIN
                        // CduPurchPost.VerifIntegrationConsomCpt(RecItemJournalLine);
                        //    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post",RecItemJournalLine);
                        //  END
                        //  ELSE;
                        IF RecItemJournalLine.FINDFIRST THEN
                            REPEAT
                                CUItemJnlPostLine.RUN(RecItemJournalLine);
                            UNTIL RecItemJournalLine.NEXT = 0;
                        RecItemJournalLine.SETRANGE("Journal Template Name", RecInventorySetup."Model Feuille Article");
                        RecItemJournalLine.SETRANGE("Journal Batch Name", RecInventorySetup."Nom Model Par Defaut");
                        //RecItemJournalLine.SETRANGE(Utilisateur,USERID);
                        RecItemJournalLine.DELETEALL;
                        MESSAGE(Text002);
                    end;

                }
                action(Imprimer)
                {
                    Caption = 'Imprimer';
                    ShortCutKey = 'F12';
                    Image = Print;

                    trigger OnAction()
                    begin
                        RecEnteteGasoil.SETRANGE(Journee, rec.Journee);
                        RecEnteteGasoil.SETRANGE(Cuve, rec.Cuve);
                        REPORT.RUNMODAL(REPORT::"Fiche Stock Gasoil", TRUE, TRUE, RecEnteteGasoil);
                    end;
                }
            }


        }
        area(Promoted)

        {

            actionref(Imprimer1; Imprimer)
            {
            }
            actionref(Valider1; Valider)
            {

            }

        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        usersteup: Record "User Setup";
    begin
        if usersteup.Get(UserId) then begin
            rec.Chantier := usersteup.Affaire;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        usersteup: Record "User Setup";
    begin
        //EnableControl;
    end;

    trigger OnOpenPage()
    var
        RecUserSetup: Record "User Setup";
        RecLoc: Record Location;
        Filter: Text;
    begin
        EnableControl;
        /* if RecUserSetup.Get(UserId) then begin
             //HS
             Rec.FilterGroup(2);
             if RecUserSetup.Cuve <> '' then
                 Rec.SetRange(cuve, RecUserSetup.Cuve)
             else begin
                 if RecUserSetup.Affaire <> '' then begin
                     RecLoc.Reset();
                     RecLoc.SetRange(Affaire, RecUserSetup.Affaire);
                     if RecLoc.FindSet() then begin
                         repeat
                             Filter += RecLoc.Code + '|';
                         until RecLoc.Next() = 0;
                     end;
                     Rec.SetFilter(cuve, CopyStr(Filter, 1, StrLen(Filter) - 1));
                 end;
                 //HS
             end;
             Rec.FilterGroup(0);
         end;*/
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        IntIndexDebut := 0;
        rec.Journee := TODAY;
        IF RecInventorySetup.GET THEN;
        rec."Article Gasoil" := RecInventorySetup."Article Gasoil";
        rec.Utilisateur := USERID;
        RecItem.SETFILTER("Location Filter", rec.Cuve);
        RecItem.SETRANGE("No.", rec."Article Gasoil");
        IF RecItem.FINDFIRST THEN BEGIN
            RecItem.CALCFIELDS(Inventory);
            rec."Index Depart" := RecItem.Inventory;
        END;
    end;

    var
        "RecVéhicule": Record "Véhicule";
        "RecMissionEnregistré": Record "Mission Enregistré";
        "RecPriseCarburantEnregistré": Record "Prise carburant Enregistré";
        RecLigneFicheGasoil: Record "Ligne Fiche Gasoil";
        RecEnteteGasoil: Record "Entete Fiche Gasoil";
        RecItemJournalLine: Record "Item Journal Line";
        CdeNomFeuille: Text[255];
        RecItemJournalTemplate: Record "Item Journal Template";
        RecInventorySetup: Record "Inventory Setup";
        RecUserSetup: Record "User Setup";
        RecItem: Record Item;
        RecParametreParc: Record "Paramétre Parc";
        CdeLocation: Code[20];
        CdeGasoil: Code[20];
        IntIndexDebut: Integer;
        IntIndexFinal: Integer;
        "IntQteCumulé": Decimal;
        IntNumLigne: Integer;
        CdeNumDoc: Code[20];
        CduNoSeriesRespCentManagement: Codeunit NoSeriesRespCenterManagement;
        CduPurchPost: Codeunit "Purch.-Post";
        IntSequence: Integer;
        CUItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        DecCentreDeGestion: Code[20];
        RespCenter: Record "Responsibility Center";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text001: label 'Valider la journéé?';
        Text002: label 'Validation Achevée Avec Succée';
        Text003: label 'Fiche N° %1';
        SubGasoilEDITABLE: Boolean;
        recLocation: Record Location;


    procedure EnableControl()
    begin
        IF rec.Statut = rec.Statut::Valider THEN BEGIN
            CurrPage.EDITABLE := FALSE;
            SubGasoilEDITABLE := FALSE;
        END
        ELSE BEGIN
            CurrPage.EDITABLE := TRUE;
            SubGasoilEDITABLE := TRUE;
        END;
    end;


    procedure InitRecord()
    var
        lNoteOfExpensesIntegr: Codeunit "Note of Expenses integr.";
    begin
        if recLocation.Get(rec.Cuve) then;
        NoSeriesMgt.SetDefaultSeries(rec."No.", recLocation."No. Series Gasoil");



    end;


    procedure AssistEdit(OldPurchHeader: Record "Purchase Header"): Boolean
    begin
    end;

    local procedure TestNoSeries(): Boolean
    var
    //DYS
    // lSubscrSetup: Record 8001900;
    begin

        if recLocation.Get(rec.Cuve) then;
        recLocation.TestField("No. Series Gasoil");
    end;

    local procedure GetNoSeriesCode(): Code[10]
    var
    //DYS
    // lSubscrSetup: Record 8001900;
    begin
        if recLocation.Get(rec.Cuve) then;
        exit(recLocation."No. Series Gasoil");
    end;

    local procedure GetPostingNoSeriesCode(): Code[10]
    begin
    end;

    local procedure TestNoSeriesDate(No: Code[20]; NoSeriesCode: Code[10]; NoCapt: Text[1024]; NoSeriesCapt: Text[1024])
    var
        NoSeries: Record "No. Series";
    begin
        IF (No <> '') AND (NoSeriesCode <> '') THEN BEGIN
            NoSeries.GET(NoSeriesCode);
            IF NoSeries."Date Order" THEN
                ERROR(Text001);
        END;
    end;
}

