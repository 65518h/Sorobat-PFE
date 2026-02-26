PageExtension 50001 "Company Information_PagEXT" extends "Company Information"
{
    layout
    {

        addafter("VAT Registration No.")
        {
            field("Entete de page"; Rec."Entete de page")
            {
                ApplicationArea = all;
            }
            field("Pied de page"; Rec."Pied de page")
            {
                ApplicationArea = all;
            }
            field("N° CNSS"; rec."N° CNSS")
            {
                ApplicationArea = all;


            }
        }
        addafter("Home Page")
        {
            field("Picture No."; rec."Picture No.")
            {
                ApplicationArea = all;
            }
            field("Default Language Code"; rec."Default Language Code")
            {
                ApplicationArea = all;
            }
            //GL2024 Declaration Employeur
            field("Activite Contribuable"; Rec."Activite Contribuable")
            {
                ApplicationArea = all;
            }
            field("Matricule Fiscale"; Rec."Matricule Fiscale") { ApplicationArea = all; }
            field(Activite; Rec.Activite) { ApplicationArea = all; }
            field("Base Test"; Rec."Base Test") { ApplicationArea = all; }
        }
    }
    actions
    {

        addafter("Application Settings")
        {
            group("&Picture")
            {
                Caption = '&Photo';
                Image = Company;
                action("Modification Date Facture")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = true;

                    trigger OnAction()
                    var
                        RecPurchInvHeader: Record "Purch. Inv. Header";
                        RecGLEntry: Record "G/L Entry";
                        RecVATEntry: Record "VAT Entry";
                        RecVendorLedgerEntry: Record "Vendor Ledger Entry";
                        RecDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
                        RecValueEntry: Record "Value Entry";
                        Cpt: Integer;
                    begin
                        Cpt := 0;
                        RecPurchInvHeader.Reset();
                        RecPurchInvHeader.SetFilter("No.", 'fa26000*');
                        if RecPurchInvHeader.FindSet() then
                            repeat
                                RecGLEntry.Reset();
                                RecGLEntry.SetRange("Document No.", RecPurchInvHeader."No.");
                                if RecGLEntry.FindSet() then begin
                                    repeat
                                        RecGLEntry."Posting Date" := RecPurchInvHeader."Document Date";
                                        RecGLEntry.Modify();
                                    until RecGLEntry.Next() = 0;
                                end;



                                RecVATEntry.Reset();
                                RecVATEntry.SetRange("Document No.", RecPurchInvHeader."No.");
                                if RecVATEntry.FindSet() then begin
                                    repeat
                                        RecVATEntry."Posting Date" := RecPurchInvHeader."Document Date";
                                        RecVATEntry.Modify();
                                    until RecVATEntry.Next() = 0;
                                end;



                                RecVendorLedgerEntry.Reset();
                                RecVendorLedgerEntry.SetRange("Document No.", RecPurchInvHeader."No.");
                                if RecVendorLedgerEntry.FindSet() then begin
                                    repeat
                                        RecVendorLedgerEntry."Posting Date" := RecPurchInvHeader."Document Date";
                                        RecVendorLedgerEntry.Modify();
                                    until RecVendorLedgerEntry.Next() = 0;
                                end;


                                RecDetailedVendorLedgEntry.Reset();
                                RecDetailedVendorLedgEntry.SetRange("Document No.", RecPurchInvHeader."No.");
                                if RecDetailedVendorLedgEntry.FindSet() then begin
                                    repeat
                                        RecDetailedVendorLedgEntry."Posting Date" := RecPurchInvHeader."Document Date";
                                        RecDetailedVendorLedgEntry.Modify();
                                    until RecDetailedVendorLedgEntry.Next() = 0;
                                end;


                                RecValueEntry.Reset();
                                RecValueEntry.SetRange("Document No.", RecPurchInvHeader."No.");
                                if RecValueEntry.FindSet() then begin
                                    repeat
                                        RecValueEntry."Posting Date" := RecPurchInvHeader."Document Date";
                                        RecValueEntry.Modify();
                                    until RecValueEntry.Next() = 0;
                                end;
                                RecPurchInvHeader."Posting Date" := RecPurchInvHeader."Document Date";
                                RecPurchInvHeader.Modify();
                                Cpt += 1;
                            until RecPurchInvHeader.Next() = 0;
                        Message('Done %1', cpt);

                    end;
                }
                action("Modification Job 2026")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        recpurchaseheader: Record "Purchase Header";
                        recpurchaseline: Record "Purchase Line";
                        Cpteur: Integer;
                    begin
                        Cpteur := 0;
                        recpurchaseheader.Reset();
                        recpurchaseheader.SetFilter("No.", 'CMDABF260000*');
                        if recpurchaseheader.FindSet() then
                            repeat
                                recpurchaseline.Reset();
                                recpurchaseline.SetRange("Document No.", recpurchaseheader."No.");
                                if recpurchaseline.FindSet() then begin
                                    repeat
                                        recpurchaseline."Job No." := '';
                                        recpurchaseline."Job Task No." := '';
                                        recpurchaseline.Modify();
                                    until recpurchaseline.Next() = 0;
                                end;
                            until recpurchaseheader.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Modification statut DA 2025")



                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecPurchaseRequest: Record "Purchase Request";
                        RecPurchaseRequestLine: Record "Purchase Request Line";
                        DateDebut: Date;
                        DateFin: Date;
                        Cpteur: Integer;
                    begin
                        Cpteur := 0;
                        RecPurchaseRequest.Reset();
                        // RecPurchaseRequest.SetRange("Job No.", 'PCENTRAL');
                        // RecPurchaseRequest.SetFilter("No.", '*2500*');
                        RecPurchaseRequest.SetFilter("Document Date", '%1..%2', 20250101D, 20251231D);
                        if RecPurchaseRequest.FindSet() then
                            repeat
                            begin
                                RecPurchaseRequestLine.Reset();
                                RecPurchaseRequestLine.SetRange("Document No.", RecPurchaseRequest."No.");
                                if RecPurchaseRequestLine.FindSet() then begin
                                    repeat
                                        RecPurchaseRequestLine.Statut := RecPurchaseRequestLine.Statut::"approved";
                                        RecPurchaseRequestLine.Modify();
                                    until RecPurchaseRequestLine.Next() = 0;

                                end;
                                RecPurchaseRequest.Statut := RecPurchaseRequest.Statut::approved;
                                RecPurchaseRequest.Modify();

                            end;
                            Cpteur := Cpteur + 1;
                            until RecPurchaseRequest.Next() = 0;

                        Message('Done %1', Cpteur);
                    end;
                }
                action("Modification statut DA")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecPurchaseRequest: Record "Purchase Request";
                        RecPurchaseRequestLine: Record "Purchase Request Line";
                        RecPurchaseHeader: Record "Purchase Header";
                        RecPurchaseLine: Record "Purchase Line";
                    begin
                        RecPurchaseRequest.Reset();
                        RecPurchaseRequest.SetFilter("Associated Purchase Order", '<>%1', '');
                        RecPurchaseRequest.SetRange(Statut, RecPurchaseRequest.Statut::"Fully Supported");
                        if RecPurchaseRequest.FindSet() then begin
                            repeat
                            begin
                                RecPurchaseHeader.Reset();
                                RecPurchaseHeader.SetRange("N° Demande d'achat", RecPurchaseRequest."No.");
                                RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
                                if RecPurchaseHeader.FindSet() then begin
                                    RecPurchaseLine.Reset();
                                    RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
                                    if RecPurchaseLine.FindSet() then
                                        repeat
                                        begin
                                            RecPurchaseLine."Purchase Request No." := RecPurchaseHeader."N° Demande d'achat";
                                            RecPurchaseLine.Modify();
                                        end;
                                        until RecPurchaseLine.Next() = 0;
                                    RecPurchaseHeader."Purchase Request No." := RecPurchaseHeader."N° Demande d'achat";
                                    RecPurchaseHeader.Modify();
                                end;
                            end;
                            until RecPurchaseRequest.Next() = 0;
                        end;
                        Message('Done %1', RecPurchaseRequest.Count());
                    end;
                }
                action("Modification statut DA 2")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = true;

                    trigger OnAction()
                    var
                        RecPurchaseRequest: Record "Purchase Request";
                        RecPurchaseRequestLine: Record "Purchase Request Line";
                        RecPurchaseHeader: Record "Purchase Header";
                        RecPurchaseLine: Record "Purchase Line";
                        Cpt: Integer;
                    begin
                        Cpt := 0;
                        RecPurchaseRequest.Reset();
                        RecPurchaseRequest.SetFilter("Associated Purchase Order", '<>%1', '');
                        RecPurchaseRequest.SetRange(Statut, RecPurchaseRequest.Statut::approved);
                        if RecPurchaseRequest.FindSet() then begin
                            repeat
                            begin
                                RecPurchaseHeader.Reset();
                                RecPurchaseHeader.SetRange("N° Demande d'achat", RecPurchaseRequest."No.");
                                RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
                                if RecPurchaseHeader.FindSet() then begin
                                    RecPurchaseLine.Reset();
                                    RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
                                    if RecPurchaseLine.FindSet() then
                                        repeat
                                        begin
                                            RecPurchaseLine."Purchase Request No." := RecPurchaseHeader."N° Demande d'achat";
                                            RecPurchaseLine.Modify();
                                        end;
                                        until RecPurchaseLine.Next() = 0;
                                    RecPurchaseHeader."Purchase Request No." := RecPurchaseHeader."N° Demande d'achat";
                                    RecPurchaseHeader.Modify();
                                end;
                                RecPurchaseRequest.Statut := RecPurchaseRequest.Statut::"Fully Supported";
                                RecPurchaseRequest.Modify();
                                Cpt += 1;
                            end;
                            until RecPurchaseRequest.Next() = 0;
                        end;
                        Message('Done %1', Cpt);
                    end;
                }

                action("Assignation N° Order dans LinePR")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecPurchaseRequest: Record "Purchase Request";
                        RecPurchaseRequestLine: Record "Purchase Request Line";
                        RecPurchaseHeader: Record "Purchase Header";
                        RecPurchaseLine: Record "Purchase Line";
                    begin
                        RecPurchaseRequest.Reset();
                        RecPurchaseRequest.SetFilter("Associated Purchase Order", '<>%1', '');
                        RecPurchaseRequest.SetRange(Statut, RecPurchaseRequest.Statut::"Fully Supported");
                        if RecPurchaseRequest.FindSet() then begin
                            repeat
                            begin
                                RecPurchaseRequest.CalcFields("Associated Purchase Order");
                                RecPurchaseRequestLine.Reset();
                                RecPurchaseRequestLine.SetRange("Document No.", RecPurchaseRequest."No.");
                                if RecPurchaseRequestLine.FindSet() then
                                    repeat
                                    begin
                                        RecPurchaseRequestLine."Associated Purchase Order" := RecPurchaseRequest."Associated Purchase Order";
                                        RecPurchaseRequestLine.Modify();
                                    end;
                                    until RecPurchaseRequestLine.Next() = 0;

                            end;
                            until RecPurchaseRequest.Next() = 0;
                        end;
                        Message('Done %1', RecPurchaseRequest.Count());
                    end;
                }

                action("TransfertSTDJobToDysJob")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        CDUBatchJobTransfer: Codeunit "Item Jnl.-Post Line_CDU22";
                    begin
                        CDUBatchJobTransfer.TransfertSTDJobToDysJob();
                        Message('Done');
                    end;
                }
                action("Axe")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = true;

                    trigger OnAction()
                    var
                        CDUBatchJobTransfer: Codeunit "Item Jnl.-Post Line_CDU22";
                        RecPurchaseLine: Record "Purchase Line";
                        RecPurchaseHeader: Record "Purchase Header";
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                        Shouldreleased: Boolean;
                        ugyg: Record "Item Unit of Measure";
                    begin

                    end;
                }
                action("modification Ligne Paie Enregistrer")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecSalaryLine: Record 52048901;
                        RecEmployee: Record Employee;
                    begin
                        RecSalaryLine.Reset();
                        RecSalaryLine.SetFilter(Year, '%1..%2', 2024, 2025);
                        if RecSalaryLine.FindSet() then begin
                            repeat
                                if RecEmployee.Get(RecSalaryLine.Employee) then begin
                                    RecSalaryLine.Fonction := RecEmployee.Fonction;
                                    RecSalaryLine."Statistics Group Code" := RecEmployee."Statistics Group Code";
                                    RecSalaryLine."Statistic Gpe Descrip" := RecEmployee."Statistic Gpe Descrip";
                                    RecSalaryLine.Service := RecEmployee.Service;
                                    RecSalaryLine."Description Service" := RecEmployee."Description Service";
                                    RecSalaryLine.Modify();
                                end;

                            until RecSalaryLine.Next() = 0;
                        end;

                        Message('Done');
                    end;
                }
                action("modification tache projet")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecPurchaseLine: Record "purchase Line";
                        RecReceptLine: Record "Purch. Rcpt. Line";
                    begin
                        RecPurchaseLine.Reset();
                        RecPurchaseLine.SetRange("Document Type", RecPurchaseLine."Document Type"::Invoice);
                        RecPurchaseLine.SetFilter("Receipt No.", '<>%1', '');
                        RecPurchaseLine.SetFilter("Job No.", '<>%1', '');
                        if RecPurchaseLine.FindSet() then
                            repeat
                            begin
                                // RecReceptLine.Reset();
                                // RecReceptLine.SetRange("Document No.", RecPurchaseLine."Receipt No.");
                                // RecReceptLine.SetRange("Line No.", RecPurchaseLine."Receipt Line No.");
                                // if RecReceptLine.FindFirst() then begin
                                //     RecPurchaseLine."Job Task No." := RecReceptLine."Job Task No.";
                                RecPurchaseLine."Job Task No." := '0';
                                RecPurchaseLine.Modify();
                                //            end;
                            end;
                            until RecPurchaseLine.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Modification statut article")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecItem: Record Item;
                        RecLedgerENTRY: Record "Item Ledger Entry";
                    begin
                        RecItem.Reset();
                        RecItem.SetRange(Statut, RecItem.Statut::"En Attente");
                        if RecItem.FindSet() then
                            repeat
                            begin
                                RecLedgerENTRY.Reset();
                                RecLedgerENTRY.SetRange("Item No.", RecItem."No.");
                                if RecLedgerENTRY.FindFirst() then begin
                                    RecItem.Statut := RecItem.Statut::"Validé";
                                    if RecItem.Type = RecItem.Type::Service then
                                        RecItem."Tree Code" := 'SERVice';
                                    RecItem.Modify();
                                end;
                            end;
                            until RecItem.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Modification Regime salarier")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        Rec5200: Record 5200;
                    begin
                        Rec5200.Reset();
                        Rec5200.SetRange("Employee's type", Rec5200."Employee's type"::"Hour based");
                        if Rec5200.FindSet() then
                            repeat
                            begin
                                if Rec5200."Emplymt. Contract Code" <> '' then
                                    Rec5200.Validate(Catégorie, Rec5200."Catégorie");
                                Rec5200.Modify();
                            end;
                            until Rec5200.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Update only Avavnce cashed")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    //Visible = false;
                    Visible = false;
                    trigger OnAction()
                    var
                        RecBatch: Record Batchavance2;
                        RecSalarLines: record "Rec. Salary Lines";
                    begin
                        if RecBatch.FindSet() then
                            repeat
                            begin
                                RecSalarLines.Reset();
                                RecSalarLines.SetRange("No.", RecBatch.NOSalarie);
                                RecSalarLines.SetRange("Employee", RecBatch.NOPaie);
                                if RecSalarLines.FindFirst() then begin
                                    RecSalarLines.Advances := RecBatch.avance;
                                    RecSalarLines."Net salary cashed" := RecBatch.Netcashed;
                                    RecSalarLines.Modify();
                                end;
                            end;
                            until RecBatch.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Update Avavnce cashed")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecBatch: Record Batchavance2;
                        RecSalarLines: record "Rec. Salary Lines";
                    begin
                        if RecBatch.FindSet() then
                            repeat
                            begin
                                RecSalarLines.Reset();
                                RecSalarLines.SetRange("No.", RecBatch.NOSalarie);
                                RecSalarLines.SetRange("Employee", RecBatch.NOPaie);
                                if RecSalarLines.FindFirst() then begin
                                    RecSalarLines.Advances := RecBatch.avance;
                                    // RecSalarLines."Net salary cashed" := RecSalarLines."Net salary" - RecBatch.avance - RecSalarLines."Contribution Social" - RecSalarLines."Report en -" - RecSalarLines."Ajout  en +";
                                    RecSalarLines.Modify();
                                end;
                            end;
                            until RecBatch.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Update Avavnce Paie")
                {
                    //Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        // RecBatch: Record Batchavance;
                        RecAdvanceHeader: record "Loan & Advance Header";
                        RecAdvanceEntry: record "Loan & Advance Entry";
                        RecAdvanceLine: record "Loan & Advance Lines";
                    begin
                        /*   if RecBatch.FindSet() then
                               repeat
                               begin
                                   RecAdvanceHeader.Reset();
                                   RecAdvanceHeader.SetRange("No.", RecBatch.NOAvance);
                                   if RecAdvanceHeader.FindFirst() then begin
                                       RecAdvanceHeader.Status := RecAdvanceHeader.Status::"In progress";
                                       RecAdvanceHeader."Date d'effet" := RecBatch.Dateeffet;
                                       RecAdvanceHeader."Date fin Prêt" := RecBatch.DateFin;
                                       RecAdvanceHeader.Modify();
                                       RecAdvanceLine.Reset();
                                       RecAdvanceLine.SetRange("No.", RecAdvanceHeader."No.");
                                       RecAdvanceLine.SetRange(Month, RecAdvanceLine.Month::Juillet);
                                       RecAdvanceLine.SetRange(Year, 2025);
                                       if RecAdvanceLine.FindFirst() then
                                           RecAdvanceLine.DeleteAll();
                                       RecAdvanceEntry.Reset();
                                       RecAdvanceEntry.SetRange("No.", RecAdvanceHeader."No.");
                                       RecAdvanceEntry.SetRange(Month, RecAdvanceEntry.Month::Juillet);
                                       RecAdvanceEntry.SetRange(Year, 2025);
                                       if RecAdvanceEntry.FindFirst() then
                                           RecAdvanceEntry.DeleteAll();

                                   end;

                               end;
                               until RecBatch.Next() = 0;
                           Message('Done');*/
                    end;
                }
                action("Importer entete de page")
                {
                    Caption = 'Importer entête de page';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin

                        PictureExists := rec."Entete de page".Hasvalue;
                        // if rec."Entete de page".Import('*.BMP', true) = '' then
                        /*//GL2024 License  if rec."Entete de page".Import('*.BMP') = '' then
                              exit; //GL2024 License*/
                        if PictureExists then
                            if not Confirm(Text001, false) then
                                exit;
                        CurrPage.SaveRecord;
                    end;
                }
                action("Importer Piede de page")
                {
                    Caption = 'Importer Piede de page';
                    ApplicationArea = all;

                    trigger OnAction()
                    begin

                        PictureExists := rec."Pied de page".Hasvalue;
                        //  if rec."Pied de page".Import('*.BMP', true) = '' then
                        /*//GL2024 License  if rec."Pied de page".Import('*.BMP') = '' then
                              exit; //GL2024 License*/
                        if PictureExists then
                            if not Confirm(Text001, false) then
                                exit;
                        CurrPage.SaveRecord;
                    end;
                }
                action(test)
                {
                    Caption = 'test';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        CDUtest: Codeunit 50031;
                    begin
                        CDUtest.Run();
                    end;
                }
                action(ModifDateTVA)
                {
                    Caption = 'ModifDateTVA';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        RecUserSetup: Record "User Setup";
                    begin
                        if RecUserSetup.FindSet() then
                            repeat
                            begin
                                //  RecUserSetup."Allow VAT Date From" := 20250101D;
                                RecUserSetup."Allow VAT Date To" := 20251231D;
                                RecUserSetup.Modify();
                            end;
                            until RecUserSetup.Next() = 0;
                        Message('Done');
                    end;
                }
                action(BatchModifUnitéAnexxe)
                {
                    Caption = 'BatchModifUnitéAnexxe';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        RecPurchaseline: Record "Purchase Line";
                    begin
                        RecPurchaseline.SetFilter("Document Type", '%1|%2', RecPurchaseline."Document Type"::Invoice, RecPurchaseline."Document Type"::Order);
                        RecPurchaseline.SetRange("Type article", RecPurchaseline."Type article"::Service);
                        if RecPurchaseline.FindSet() then
                            repeat
                            begin

                                if RecPurchaseline."Type article" = RecPurchaseline."Type article"::Service then begin
                                    RecPurchaseline."Unit of Measure Code" := 'UNITE';
                                    RecPurchaseline.Modify();

                                end;
                            end;
                            until RecPurchaseline.Next() = 0;
                        Message('Done');
                    end;
                }
                action(LinkDemandeachat)
                {
                    Caption = 'LinkDemandeachat';
                    ApplicationArea = all;
                    Visible = false;

                    trigger OnAction()
                    var
                        PurchaseRequest: Record "Purchase Request";
                        RecpurchaseHeader: Record "Purchase Header";
                    begin
                        PurchaseRequest.Reset();
                        if PurchaseRequest.FindSet() then begin
                            repeat
                                RecpurchaseHeader.Reset();
                                RecpurchaseHeader.SetRange("N° Demande d'achat", PurchaseRequest."No.");
                                if RecpurchaseHeader.FindFirst() then begin
                                    RecpurchaseHeader."Purchase Request No." := RecpurchaseHeader."N° Demande d'achat";
                                    RecpurchaseHeader.Modify();
                                end;
                            until PurchaseRequest.Next() = 0;
                            Message('done');

                        end;
                    end;
                }
                action(BatchModiObs)
                {
                    Caption = 'BatchModiObs';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        RecPurchaheader: Record "Purchase header";
                    begin
                        if RecPurchaheader.FindSet() then
                            repeat
                            begin
                                RecPurchaheader."Observation 1" := RecPurchaheader."Shipment Remark";
                                RecPurchaheader."Observation 2" := RecPurchaheader."Pay-to Address 2";
                                RecPurchaheader."Observation 3" := RecPurchaheader."Pay-to Name 2";
                                RecPurchaheader.Modify();
                            end;
                            until RecPurchaheader.Next() = 0;

                        Message('Done');


                    end;

                }
                action(BatchModifannexRecepaCHATENREGISTRER)
                {
                    Caption = 'BatchModifannexRecepaCHATENREGISTRER';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        RecrECEPITline: Record 121;
                    begin
                        // RecPurchaseline.SetFilter("Document Type", '%1|%2', RecPurchaseline."Document Type"::Invoice, RecPurchaseline."Document Type"::Order);
                        RecrECEPITline.Reset();
                        RecrECEPITline.SetRange(Type, RecrECEPITline.Type::"Charge (Item)");
                        if RecrECEPITline.FindSet() then
                            repeat
                            begin

                                if RecrECEPITline.Type = RecrECEPITline.Type::"Charge (Item)" then begin
                                    RecrECEPITline.Type := RecrECEPITline.Type::Item;
                                    RecrECEPITline."Type article" := RecrECEPITline."Type article"::Service;
                                    RecrECEPITline."Unit of Measure Code" := 'UNITE';
                                    RecrECEPITline.Modify();

                                end;
                            end;
                            until RecrECEPITline.Next() = 0;
                        Message('Done');
                    end;
                }
                action(BatchModifannex)
                {
                    Caption = 'BatchModifannex';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        RecPurchaseline: Record "Purchase Line";
                    begin
                        RecPurchaseline.SetFilter("Document Type", '%1|%2', RecPurchaseline."Document Type"::Invoice, RecPurchaseline."Document Type"::Order);
                        RecPurchaseline.SetRange(Type, RecPurchaseline.Type::"Charge (Item)");
                        if RecPurchaseline.FindSet() then
                            repeat
                            begin

                                if RecPurchaseline.Type = RecPurchaseline.Type::"Charge (Item)" then begin
                                    RecPurchaseline.Type := RecPurchaseline.Type::Item;
                                    RecPurchaseline."Type article" := RecPurchaseline."Type article"::Service;
                                    RecPurchaseline.Modify();


                                end;
                            end;
                            until RecPurchaseline.Next() = 0;
                        Message('Done');
                    end;
                }
                action("Modif fiche Gasoil Encours")
                {
                    Caption = 'Modif fiche Gasoil Encours';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        EnteteFicheGasoi: Record "Entete Fiche Gasoil";
                        LigneFicheGasoil: Record "Ligne Fiche Gasoil";
                    begin
                        EnteteFicheGasoi.Reset();
                        EnteteFicheGasoi.SetRange(Statut, EnteteFicheGasoi.Statut::"En Cours");
                        if EnteteFicheGasoi.FindSet() then
                            repeat
                            begin
                                LigneFicheGasoil.Reset();
                                LigneFicheGasoil.SetRange("Document No.", EnteteFicheGasoi."No.");
                                if LigneFicheGasoil.FindSet() then
                                    repeat
                                    begin
                                        LigneFicheGasoil.Statut := LigneFicheGasoil.Statut::Valider;
                                        LigneFicheGasoil.Modify();
                                    end;
                                    until LigneFicheGasoil.Next() = 0;
                                EnteteFicheGasoi.Statut := EnteteFicheGasoi.Statut::Valider;
                                EnteteFicheGasoi.Modify();
                            end;
                            until EnteteFicheGasoi.Next() = 0;

                        Message('Done');
                    end;
                }

                action(BatchDA)
                {
                    Caption = 'BatchDA';
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        PurchaseRequest: Record "Purchase Request";
                        purchaseRequestLine: Record "Purchase Request Line";
                        RecSalesheaer: Record "Sales Header";
                        RecSalesLine: Record "Sales Line";
                        RecItem: Record Item;
                        RecVéhicule: Record Véhicule;
                        RecJob: Record Job;
                    begin
                        PurchaseRequest.DeleteAll();
                        purchaseRequestLine.DeleteAll();
                        RecSalesheaer.Reset();
                        RecSalesheaer.SetFilter("No.", 'DA*|RN*|PARC*');
                        if RecSalesheaer.FindSet() then begin
                            repeat

                                PurchaseRequest.Init();
                                PurchaseRequest."No." := RecSalesheaer."No.";
                                PurchaseRequest."Document Type" := PurchaseRequest."Document Type"::Quote;
                                if not RecVéhicule.Get(RecSalesheaer.Engin) then begin
                                    PurchaseRequest.Engin := RecSalesheaer.Engin;
                                    PurchaseRequest."Description Engin" := RecVéhicule."Désignation";
                                    PurchaseRequest.Type := RecVéhicule.Type;
                                    PurchaseRequest."Serial No." := RecVéhicule."No. Series";
                                end
                                else
                                    PurchaseRequest.Validate(Engin, RecSalesheaer.Engin);
                                if RecJob.Get(RecSalesheaer."Job No.") then;
                                PurchaseRequest."Job No." := RecSalesheaer."Job No.";
                                PurchaseRequest."Location Code" := RecSalesheaer."Location Code";
                                PurchaseRequest."Job Description" := RecJob.Description;
                                PurchaseRequest."Requester ID" := RecSalesheaer."Requester ID";
                                PurchaseRequest."Posting Date" := RecSalesheaer."Posting Date";
                                PurchaseRequest."Document Date" := RecSalesheaer."Document Date";
                                PurchaseRequest.Service := RecSalesheaer.Service;
                                PurchaseRequest."Request Type" := RecSalesheaer."Type Demande";
                                PurchaseRequest."Responsibility Center" := RecSalesheaer."Responsibility Center";
                                PurchaseRequest."Requested Receipt Date" := RecSalesheaer."Requested Delivery Date";
                                PurchaseRequest."User ID" := RecSalesheaer."User ID";
                                // PurchaseRequest.Observation := RecSalesheaer.Observation;
                                //   PurchaseRequest.Statut := RecSalesheaer.Statut;
                                PurchaseRequest.Demarcheur := RecSalesheaer."Shipping Agent Code";
                                PurchaseRequest.Insert();
                                RecSalesLine.Reset();
                                RecSalesLine.SetRange("Document No.", RecSalesheaer."No.");
                                if RecSalesLine.FindSet() then
                                    repeat
                                        purchaseRequestLine.Init();
                                        purchaseRequestLine."Document No." := RecSalesheaer."No.";
                                        purchaseRequestLine."Document Type" := purchaseRequestLine."Document Type"::Quote;
                                        purchaseRequestLine.Type := purchaseRequestLine.Type::Item;
                                        purchaseRequestLine."Line No." := RecSalesLine."Line No.";
                                        if RecSalesLine.Type = RecSalesLine.Type::"Charge (Item)" then
                                            purchaseRequestLine."Type article" := purchaseRequestLine."Type article"::Service;

                                        //   if not RecItem.Get(RecSalesLine."No.") then begin
                                        purchaseRequestLine."No." := RecSalesLine."No.";
                                        purchaseRequestLine.Description := RecSalesLine.Description;
                                        //  end
                                        //   else
                                        //      purchaseRequestLine.Validate("No.", RecSalesLine."No.");
                                        purchaseRequestLine."Vendor No." := RecSalesLine."Vendor No.";
                                        purchaseRequestLine."Location Code" := RecSalesLine."Location Code";
                                        purchaseRequestLine."Need Unit of Measure Code" := RecSalesLine."Need Unit of Measure Code";
                                        purchaseRequestLine."Unit of Measure Code" := RecSalesLine."Unit of Measure Code";
                                        purchaseRequestLine."Job No." := PurchaseRequest."Job No.";
                                        purchaseRequestLine.Quantity := RecSalesLine.Quantity;
                                        purchaseRequestLine.Insert();
                                    until RecSalesLine.Next() = 0;
                            until RecSalesheaer.Next() = 0;
                        end;
                        Message('Done');

                    end;
                }
            }








            ///GL2024


            action(ValiderLignesEnCours)
            {
                Caption = 'Valider Lignes en Cours';
                Image = Approve;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    EnteteGasoil: Record "Entete Fiche Gasoil";
                    LigneGasoil: Record "Ligne Fiche Gasoil";
                    DateDebut: Date;
                    DateFin: Date;
                begin
                    DateDebut := DMY2Date(1, 1, 2025);   // 01/01/2025
                    DateFin := DMY2Date(31, 12, 2025);   // 31/12/2025
                    // Filtrer uniquement les entêtes validées
                    EnteteGasoil.Reset();
                    EnteteGasoil.SetRange(Statut, EnteteGasoil.Statut::Valider);
                    EnteteGasoil.SetRange(Journee, DateDebut, DateFin); // Filtre par date
                    if EnteteGasoil.FindSet() then
                        repeat
                            // Vérifier s'il existe des lignes "En cours"
                            LigneGasoil.Reset();
                            LigneGasoil.SetRange("Document No.", EnteteGasoil."No.");
                            LigneGasoil.SetRange(Statut, LigneGasoil.Statut::"En cours");

                            if LigneGasoil.FindSet() then
                                repeat
                                    LigneGasoil.Statut := LigneGasoil.Statut::Valider;
                                    LigneGasoil.Modify();
                                //   Message(LigneGasoil."Document No.");
                                until LigneGasoil.Next() = 0;

                        until EnteteGasoil.Next() = 0;

                    Message('Toutes les lignes en cours des entêtes validées ont été passées à Validé.');
                end;
            }



            ///GL2024


            action(InsertBaseUOMForEmptyItems)
            {
                Caption = 'Insert Base UOM (Missing Only)';
                ApplicationArea = All;
                Image = Add;

                trigger OnAction()
                var
                    ItemRec: Record Item;
                    ItemUOM: Record "Item Unit of Measure";
                    CountInserted: Integer;
                begin
                    CountInserted := 0;

                    ItemRec.Reset();
                    if ItemRec.FindSet() then
                        repeat
                            // Traiter uniquement si Base Unit of Measure n'est pas vide
                            if ItemRec."Base Unit of Measure" <> '' then begin

                                ItemUOM.Reset();
                                ItemUOM.SetRange("Item No.", ItemRec."No.");
                                ItemUOM.SetRange(Code, ItemRec."Base Unit of Measure");

                                // Insérer seulement si la Base UOM n'existe pas encore
                                if not ItemUOM.FindFirst() then begin
                                    ItemUOM.Init();
                                    ItemUOM."Item No." := ItemRec."No.";
                                    ItemUOM.Code := ItemRec."Base Unit of Measure";
                                    ItemUOM."Qty. per Unit of Measure" := 1;
                                    ItemUOM.Insert();

                                    CountInserted += 1;
                                end;

                            end;
                        until ItemRec.Next() = 0;

                    Message('%1 Item Unit of Measure inserted.', CountInserted);
                end;
            }




            action(ChangerStatutLignesEnCoursPointage)
            {
                Caption = 'ChangerStatutLignesEnCoursPointage';
                Image = Approve;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    EntetePointage: Record "Entete Pointage Vehicule";
                    LignePointage: Record "Ligne Pointage Vehicule";
                    DateDebut: Date;
                    DateFin: Date;
                begin
                    DateDebut := DMY2Date(1, 1, 2025);   // 01/01/2025
                    DateFin := DMY2Date(31, 12, 2025);   // 31/12/2025
                    // Filtrer uniquement les entêtes validées
                    EntetePointage.Reset();
                    EntetePointage.SetRange(Statut, EntetePointage.Statut::"Validé");
                    EntetePointage.SetRange(Journee, DateDebut, DateFin); // Filtre par date
                    if EntetePointage.FindSet() then
                        repeat
                            // Vérifier s'il existe des lignes "En cours"
                            LignePointage.Reset();
                            LignePointage.SetRange("Document N°", EntetePointage."N° Document");
                            //    LignePointage.SetRange("Statut Entete", LignePointage."Statut Entete"::Ouvert);
                            if LignePointage.FindSet() then
                                repeat
                                    LignePointage."Statut Entete" := LignePointage."Statut Entete"::"Validé";
                                    LignePointage.Modify();
                                //   Message(LigneGasoil."Document No.");
                                until LignePointage.Next() = 0;
                        until EntetePointage.Next() = 0;

                    Message('Toutes les lignes en cours des entêtes validées ont été passées à Validé.');
                end;
            }
            action(ChangerStatutPointageVehicule)
            {
                Caption = 'ChangerStatutPointageVehicule';
                Image = Approve;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    EntetePointage: Record "Entete Pointage Vehicule";
                    LignePointage: Record "Ligne Pointage Vehicule";

                begin

                    EntetePointage.Reset();
                    EntetePointage.SetRange(Statut, EntetePointage.Statut::Ouvert);
                    if EntetePointage.FindSet() then
                        repeat
                            LignePointage.Reset();
                            LignePointage.SetRange("Document N°", EntetePointage."N° Document");
                            if LignePointage.FindSet() then
                                repeat
                                    LignePointage."Statut Entete" := LignePointage."Statut Entete"::"Validé";
                                    LignePointage.Modify();
                                until LignePointage.Next() = 0;
                            EntetePointage.Statut := EntetePointage.Statut::"Validé";
                            EntetePointage.Modify();
                        until EntetePointage.Next() = 0;

                    Message('Toutes les lignes en cours des entêtes validées ont été passées à Validé.');
                end;
            }


            action(Modifsalary)
            {
                Caption = 'Modifsalary';
                Image = Approve;
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    EntetePointage: Record "Entete Pointage Vehicule";
                    LignePointage: Record "Ligne Pointage Vehicule";
                    DateDebut: Date;
                    DateFin: Date;
                    RecEmployee: Record Employee;
                begin
                    RecEmployee.Reset();
                    RecEmployee.SetRange(Blocked, false);
                    if RecEmployee.FindSet() then
                        repeat
                            RecEmployee."Employee Posting Group" := 'SALARIER';
                            RecEmployee.Modify();
                        until RecEmployee.Next() = 0;
                    Message('Done');
                end;
            }


            action(TransferData)
            {
                Caption = 'Transférer Données Écritures Comptables Article';
                Image = Transfer;

                trigger OnAction()
                var
                    ItemLEntry: Record "Item Ledger Entry";
                    ItemLEntryHistory: Record "Item Ledger Entry History";
                begin
                    if not Confirm('Voulez-vous transférer les données de Table Écritures Comptables Article vers Table Historique Écritures Comptables Article ?', false) then
                        exit;

                    ItemLEntry.Reset;
                    if ItemLEntry.FindSet() then begin
                        repeat
                            ItemLEntryHistory.Init;
                            ItemLEntryHistory.TransferFields(ItemLEntry, true);
                            ItemLEntryHistory.Insert();
                        until ItemLEntry.Next() = 0;

                        Message('Transfert terminé avec succès.');
                    end else
                        Message('Aucune donnée trouvée dans Table Écritures Comptables Article.');
                end;
            }
            action(DeleteAllTableItemLEntry)
            {
                Caption = 'Supprimer Données Écritures Comptables Article';
                Image = Delete;

                trigger OnAction()
                var
                    ItemLEntry: Record "Item Ledger Entry";
                begin
                    if not Confirm('Êtes-vous sûr de vouloir supprimer toutes les données de Table Écritures Comptables Article ?', false) then
                        exit;

                    ItemLEntry.DeleteAll();

                    Message('Toutes les données de Table Écritures Comptables Article ont été supprimées.');
                end;
            }



        }

        addafter(Category_Category4)
        {
            group("&Picture1")
            {
                Caption = '&Photo1';
                actionref("Importer entete de page1"; "Importer entete de page")
                {
                }
                actionref("Importer Piede de page1"; "Importer Piede de page")
                {
                }
                actionref(test1; test)
                {
                }

            }

        }
    }




    var
        PictureExists: Boolean;
        Text001: label 'Voulez-vous remplacer la photo existante?';
}

