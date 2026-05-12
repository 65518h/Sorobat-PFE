PageExtension 50025 "Item Journal_PagEXT" extends "Item Journal"
{
    layout
    {
        modify("Discount Amount")
        {
            visible = false;
        }
        modify(EntryType)
        {
            Editable = false;
        }

        addafter("Posting Date")
        {
            field("Entry Type2"; Rec."Entry Type")
            {
                Editable = false;
                ApplicationArea = all;
                Visible = false;
            }
        }
        addafter("Document No.")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
            }
            field("Filtre Article"; Rec."Filtre Article")
            {
                Visible = FALSE;
                ApplicationArea = all;
            }


        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                OldItemNo, ItemNo : Code[20];
                ItemDescription: Text[100];
                Item: Record Item;
            begin
                // >> HJ SORO 08-01-2015
                /*   IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN BEGIN
                       IF RecItemJournalTemplate."Synchronisation Automatique" THEN rec.Synchronise := TRUE;
                       IF RecItemJournalTemplate."Transfert Inter Chantier" THEN rec."Transfert Inter Chantier" := TRUE;

                   END;*/
                if ItemNo <> OldItemNo then begin
                    ItemDescription := '';
                    if ItemNo <> '' then
                        if Item.Get(ItemNo) then
                            ItemDescription := Item.Description;
                    OldItemNo := ItemNo;
                end;

                //     ItemJnlMgt.GetItem(Rec."Item No.", ItemDescription);
                rec.ShowShortcutDimCode(ShortcutDimCode);
                // >> HJ SORO 07-12-2016
                IF CompanyInformation.GET THEN
                    IF CompanyInformation."Location Code" <> '' THEN rec.VALIDATE("Location Code", CompanyInformation."Location Code");
                // >> HJ SORO 07-12-2016

                // >> HJ SORO 08-01-2015
            end;
        }

        addafter(Description)
        {
            field("Source No."; Rec."Source No.")
            {
                ApplicationArea = all;
            }
            field("Source Type"; Rec."Source Type")
            {
                ApplicationArea = all;
            }
            field("Inventory Posting Group"; Rec."Inventory Posting Group")
            {
                ApplicationArea = all;
            }
            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = all;
                Editable = FALSE;
                Caption = 'N° Affaire';
                Visible = "Lieu De Livraison / ProvenanceVISIBLE";

            }

            field("Code Variante"; Rec."Code Variante")
            {
                Visible = "Code VarianteVISIBLE";
                ApplicationArea = all;
                Editable = FALSE;
            }
            field(Heure; Rec.Heure)
            {
                Visible = HeureVISIBLE;
                ApplicationArea = all;

            }



            field("Shelf No."; Rec."Shelf No.")
            {
                ApplicationArea = all;
                caption = 'N° emplacement';
            }
            field("Filtre Materiel"; Rec."Filtre Materiel")
            {
                ApplicationArea = all;
            }
            field("N° Materiel"; Rec."N° Materiel")
            {
                Visible = "N° MaterielVISIBLE";
                ApplicationArea = all;
            }
            field(Receptioneur; Rec.Receptioneur)
            {
                ApplicationArea = all;
            }
            field("Index Vehicule"; Rec."Index Vehicule")
            {
                ApplicationArea = all;
            }
            field(Benificiaire; Rec.Benificiaire)
            {
                ApplicationArea = all;
            }
            field("Vehicule Transporteur"; Rec."Vehicule Transporteur")
            {
                ApplicationArea = all;
            }

            field(Heure2; Rec.Heure)
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("External Document No.3"; Rec."External Document No.")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field("Type Index"; Rec."Type Index")
            {
                Visible = "Type IndexVISIBLE";
                ApplicationArea = all;
            }
            field("Index Horaire"; Rec."Index Horaire")
            {
                Visible = "Index HoraireVISIBLE";
                ApplicationArea = all;
            }
            field("Index Kilometrique"; Rec."Index Kilometrique")
            {
                Visible = "Index KilometriqueVISIBLE";
                ApplicationArea = all;
            }
            field("Document Date2"; Rec."Document Date")
            {
                ApplicationArea = all;
                Visible = FALSE;
            }
            field(Chauffeur; Rec.Chauffeur)
            {
                Visible = ChauffeurVISIBLE;
                ApplicationArea = all;
            }
            field("Nom Utilisateur"; Rec."Nom Utilisateur")
            {
                Visible = "Nom UtilisateurVISIBLE";
                ApplicationArea = all;
            }
            field("External Document No.2"; Rec."External Document No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Variant Code2"; Rec."Variant Code")
            {
                ApplicationArea = all;
                Visible = "Variant CodeVISIBLE";
            }



        }

        addbefore(Quantity)
        {
            field("Phys. Inv. Quantity"; Rec."Phys. Inv. Quantity")
            {
                ApplicationArea = all;
                Caption = 'Qte Dispo.';
            }
            field("Quantité Demandé"; Rec."Quantité Demandé")
            {
                ApplicationArea = all;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field(Observation; Rec.Observation)
            {
                ApplicationArea = all;
            }
            field("Affectation Marche"; Rec."Affectation Marche")
            {
                ApplicationArea = all;
            }

            field(Provenance; Rec.Provenance)
            {
                ApplicationArea = all;

            }

            field("Approbé"; Rec."Approbé")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    IF rec."Entry Type" = rec."Entry Type"::Purchase THEN EXIT;
                    IF rec."Entry Type" = rec."Entry Type"::"Positive Adjmt." THEN EXIT;
                    IF (rec."Item No." = '') OR (rec."Location Code" = '') THEN EXIT;
                    RecItem.SETFILTER("No.", rec."Item No.");
                    RecItem.SETFILTER("Location Filter", rec."Location Code");
                    IF RecItem.FINDFIRST THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);
                        rec."Phys. Inv. Quantity" := RecItem.Inventory;
                        IF RecItem.Inventory = 0 THEN ERROR(Text001);
                        IF RecItem.Inventory < rec.Quantity THEN ERROR(Text002);
                    END;
                end;
            }
            /*    field("Lieu De Livraison / Provenance"; Rec."Lieu De Livraison / Provenance")
                {

                    //GL2024 Visible = "Lieu De Livraison / ProvenanceVISIBLE";
                    ApplicationArea = all;
                }*/

            field("Sous Affectation Marche"; Rec."Sous Affectation Marche")
            {
                ApplicationArea = all;
            }
        }
        addafter("Reason Code")
        {
            field(Synchronise; Rec.Synchronise)
            {
                ApplicationArea = all;
                Visible = FALSE;
                Editable = FALSE;
            }
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin

                VerifStock();
                IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN
                    IF RecItemJournalTemplate."Inverser Signe" THEN IF rec.Quantity > 0 THEN rec.VALIDATE(Quantity, -rec.Quantity);
            end;
        }
        modify("Unit of Measure Code")
        {
            Visible = FALSE;
            Editable = FALSE;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                VerifStock();
            end;
        }

    }
    actions
    {
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                VeriflIgne;
            end;

            trigger OnafterAction()
            var
                myInt: Integer;
            begin
                IF NOT CONFIRM(Text005) THEN EXIT;
                RecItemJrnl.COPY(Rec);
                IF RecItemJrnl.FINDFIRST THEN
                    REPEAT
                        RecItemJrnl.Imprimer := TRUE;
                        RecItemJrnl.MODIFY;
                    UNTIL RecItemJrnl.NEXT = 0;
            end;
        }
        addafter("&Calculate Warehouse Adjustment")
        {
            action(Import)
            {
                Caption = 'Importer';
                ApplicationArea = all;
                trigger OnAction()
                VAR
                    lImport: Record Import;

                    DataPortInv: XmlPort "Imp Inv Ouv Ancien Article";
                begin

                    //+REF+IMPORT
                    DataPortInv.GETTEMPLATE(rec."Journal Template Name", rec."Journal Batch Name");
                    DataPortInv.RUN;
                    //DATAPORT.RUN(DATAPORT::"Imp Inv Ouv Ancien Article");
                    //+REF+IMPORT//
                    Currpage.UPDATE;
                end;
            }
            /*  action("Article Non Existant Suite Import")
              {
                  Caption = 'Article Non Existant Suite Import';
                  ApplicationArea = all;
                  RunObject = page "Droit Formulaire";//59998
              }*/
        }

        addafter("&Save as Standard Journal")
        {
            action(Validate2)
            {
                Caption = 'Validate 2';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    RecItemJrnl.COPY(Rec);
                    IF RecItemJrnl.FINDFIRST THEN
                        REPEAT

                            DECMNT := RecItemJrnl."Unit Cost";
                            RecItemJrnl.VALIDATE("Item No.", RecItemJrnl."Item No.");
                            RecItemJrnl.VALIDATE(Quantity, RecItemJrnl.Quantity);
                            RecItemJrnl.VALIDATE("Location Code", RecItemJrnl."Location Code");
                            RecItemJrnl."Unit Amount" := DECMNT;
                            RecItemJrnl."Unit Cost" := DECMNT;
                            RecItemJrnl.Amount := RecItemJrnl.Quantity * DECMNT;
                            RecItemJrnl.MODIFY;
                        UNTIL RecItemJrnl.NEXT = 0;
                end;
            }
        }
        modify("P&osting")
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = TRUE;
            Caption = 'Post and &Print';
            trigger OnafterAction()
            begin
                //
                VeriflIgne;
            end;
        }
        addafter("Page")
        {
            /*GL2024 action("...")
             {
                 Caption = '...';
                 ApplicationArea = All;
                 trigger OnAction()
                 begin
                     CurrPage.UPDATE;
                 end;
             }*/
            action("Validate and print")
            {
                Caption = 'Valider et imprimer';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    // HJ SORO 01/01/2015
                    //   VeriflIgne;

                    // HJ SORO 01/01/2015
                    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post+Print", Rec);
                    CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                end;
            }
            action(Validate)
            {
                Caption = 'Valider';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    // HJ SORO 01/01/2015
                    //    VeriflIgne;
                    IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN;
                    RecItemJrnl.COPY(Rec);
                    IF RecItemJrnl.FINDFIRST THEN
                        REPEAT
                            IF RecItemJournalTemplate."Materiel Obligatoire" THEN RecItemJrnl.TESTFIELD("N° Materiel");
                            IF RecItemJournalTemplate."Affaire Obligatoire" THEN RecItemJrnl.TESTFIELD("Job No.");
                            IF RecItemJournalTemplate."Affectation Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Affectation Marche");
                            IF RecItemJournalTemplate."Sous Affect Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Sous Affectation Marche");

                            IF RecItemJrnl."Entry Type" = RecItemJrnl."Entry Type"::"Positive Adjmt." THEN BEGIN
                                RecItemJrnl.TESTFIELD("External Document No.");
                                RecItemJrnl.TESTFIELD(Provenance);
                            END;
                            IF RecItemJrnl."Entry Type" = RecItemJrnl."Entry Type"::"Negative Adjmt." THEN BEGIN
                                RecItemJrnl.TESTFIELD(Benificiaire);
                                RecItemJrnl.TESTFIELD(Imprimer);
                                IF InventoryPostingGroup.GET(rec."Inventory Posting Group") THEN
                                    IF (FORMAT(InventoryPostingGroup."Frequence Changement") <> '') AND (InventoryPostingGroup.Pneumatique) THEN BEGIN
                                        IF RecVehicule.GET(Rec."N° Materiel") THEN
                                            IF NOT RecVehicule."Ne pas Tester Position Engin" THEN BEGIN
                                                RecItemJrnl.TESTFIELD(Esseyeu);
                                                RecItemJrnl.TESTFIELD(Position);
                                            END;
                                    END;

                            END;

                        // IF "Unit Cost"=0 THEN ERROR(Text003,RecItemJrnl."Item No.");
                        UNTIL RecItemJrnl.NEXT = 0;
                    // HJ SORO 01/01/2015
                    CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post", Rec);
                    CurrentJnlBatchName := rec.GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }
        addafter(EditInExcel_Promoted)
        {
            actionref("Validate and print1"; "Validate and print")
            {

            }
            actionref(Validate11; Validate)
            {

            }
        }
        addafter("&Calculate Warehouse Adjustment_Promoted")
        {
            actionref(import1; import)
            {

            }
            /*  actionref("Article Non Existant Suite Import1"; "Article Non Existant Suite Import")
              {

              }*/
            actionref("Validate1"; "Validate2")
            {

            }


        }
    }

    trigger OnAfterGetRecord()
    begin

        // >> HJ DSFT 23 03 2012
        IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN CdeNomFeuille := RecItemJournalTemplate.Description;
        IF CdeNomFeuille = '' THEN CdeNomFeuille := rec."Journal Batch Name";

        /*   IF RecItemJournalTemplate.Consommation THEN BEGIN
               "Code VarianteVISIBLE" := TRUE;
               "Variant CodeVISIBLE" := FALSE;
           END;

           IF RecItemJournalTemplate.Production THEN BEGIN
               "Code VarianteVISIBLE" := FALSE;
               "Variant CodeVISIBLE" := TRUE;
           END;*/


        IF RecItemJournalTemplate."Afficher Index" THEN BEGIN
            "Index HoraireVISIBLE" := TRUE;
            "Index KilometriqueVISIBLE" := TRUE;
            "Type IndexVISIBLE" := TRUE;
        END
        ELSE BEGIN
            "Index HoraireVISIBLE" := FALSE;
            "Index KilometriqueVISIBLE" := FALSE;
            "Type IndexVISIBLE" := FALSE;
        END;
        IF RecItemJournalTemplate."Afficher Heure" THEN
            HeureVISIBLE := TRUE ELSE
            HeureVISIBLE := FALSE;
        IF RecItemJournalTemplate."Afficher Heure" THEN
            HeureVISIBLE := TRUE ELSE
            HeureVISIBLE := FALSE;

        IF RecItemJournalTemplate."Afficher Nom Utilisateur" THEN
            "Nom UtilisateurVISIBLE" := TRUE ELSE
            "Nom UtilisateurVISIBLE" := FALSE;
        IF RecItemJournalTemplate."Afficher Affaire" THEN
            "Lieu De Livraison / ProvenanceVISIBLE" := TRUE ELSE
            "Lieu De Livraison / ProvenanceVISIBLE" := FALSE;
        IF RecItemJournalTemplate."Afficher Materiel" THEN
            "N° MaterielVISIBLE" := TRUE ELSE
            "N° MaterielVISIBLE" := FALSE;
        IF RecItemJournalTemplate."Afficher Chauffeur" THEN
            ChauffeurVISIBLE := TRUE ELSE
            ChauffeurVISIBLE := FALSE;

        // >> HJ DSFT 23 03 2012
        // RB SORO 18/04/2015    Impression
        //IF RecItemJournalTemplate.GET("Journal Template Name") THEN;
        /*{
        IF RecItemJournalTemplate."Bon Sortie" THEN
        BEGIN
           Impression.VISIBLE(FALSE);
           Valider.VISIBLE(FALSE);
        END;
        }*/
        // RB SORO 18/04/2015
        // HJ SORO 06/10/2015
        IF RecItemJournalTemplate."Affecter Utilisateur" <> UPPERCASE(USERID) THEN ERROR(Text008);
        // HJ SORO 06/10/2015

    end;


    PROCEDURE VerifStock();
    VAR
        Text001: Label 'Item not available in stock';
        Text002: Label 'The quantity in stock does not meet your request';
    BEGIN
        //  IF rec."Entry Type" = rec."Entry Type"::Purchase THEN EXIT;
        IF rec."Entry Type" = rec."Entry Type"::"Positive Adjmt." THEN EXIT;
        IF (rec."Item No." = '') OR (rec."Location Code" = '') THEN EXIT;
        RecItem.SETFILTER("No.", rec."Item No.");
        RecItem.SETFILTER("Location Filter", rec."Location Code");
        IF RecItem.FINDFIRST THEN BEGIN
            RecItem.CALCFIELDS(Inventory);
            rec."Phys. Inv. Quantity" := RecItem.Inventory;
            IF RecItem.Inventory = 0 THEN ERROR(Text001);
            IF RecItem.Inventory < rec.Quantity THEN ERROR(Text002);
        END;
    END;

    PROCEDURE VeriflIgne();
    BEGIN
        IF RecItemJournalTemplate.GET(rec."Journal Template Name") THEN;
        RecItemJrnl.COPY(Rec);
        IF RecItemJrnl.FINDFIRST THEN
            REPEAT
                IF RecItemJournalTemplate."Materiel Obligatoire" THEN RecItemJrnl.TESTFIELD("N° Materiel");
                IF RecItemJournalTemplate."Affaire Obligatoire" THEN RecItemJrnl.TESTFIELD("Job No.");
                IF RecItemJournalTemplate."Affectation Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Affectation Marche");
                IF RecItemJournalTemplate."Sous Affect Marche Obligatoire" THEN RecItemJrnl.TESTFIELD("Sous Affectation Marche");

                IF RecItemJrnl."Entry Type" = RecItemJrnl."Entry Type"::"Positive Adjmt." THEN
                    IF rec."Unit Cost" = 0 THEN ERROR(Text003, RecItemJrnl."Item No.");
            UNTIL RecItemJrnl.NEXT = 0;
    END;

    var
        ItemLedgerEntry: Record 32;
        // Text004: Label 'FRA="Numéro Piece Existante "';
        // Text005: Label 'FRA=Impression Deroulée Avec Succée ?';
        InventoryPostingGroup: Record 94;
        CompanyInformation: Record 79;
        RecVehicule: Record "Véhicule";
        "// HJ DSFT": Integer;
        CdeNomFeuille: Text[255];
        RecItemJournalTemplate: Record "Item Journal Template";
        RecItemJrnl: Record "Item Journal Line";
        UserSetup: Record "User Setup";
        DECMNT: Decimal;
        RecItem: Record Item;
        Approbateur: Boolean;
        ListeAprobateur: Text[100];
        Text003: Label 'The cost of item %1 is zero; display the unit cost field and assign a correct cost';
        Text004: Label 'Please print the voucher before validation';
        Text005: Label 'For return vouchers, approval is required; please consult the warehouse manager';
        Text006: Label 'Only %1 can approve this return voucher';
        Text007: Label 'A delivery note can only be made for your store %1';
        Text008: Label 'Access denied... This sheet, please consult your administrator';
        "Code VarianteVISIBLE": Boolean;
        "Variant CodeVISIBLE": Boolean;
        "Index HoraireVISIBLE": Boolean;
        "Index KilometriqueVISIBLE": Boolean;
        "Type IndexVISIBLE": Boolean;
        HeureVISIBLE: Boolean;
        "Nom UtilisateurVISIBLE": Boolean;
        "Lieu De Livraison / ProvenanceVISIBLE": Boolean;
        "N° MaterielVISIBLE": Boolean;
        ChauffeurVISIBLE: Boolean;
        CurrentJnlBatchName: Code[10];

        Text001: Label 'Item Journal lines have been successfully inserted from Standard Item Journal %1.';
        Text002: Label 'Standard Item Journal %1 has been successfully created.';


}



