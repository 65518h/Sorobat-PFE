Page 59991 "Recuperation Historique Cpta"
{
    SourceTable = "Recuperation Historique";
    Caption = 'Recuperation Historique Cpta';
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;

    layout
    {
        area(content)
        {
            group(Initialisation)
            {
                Caption = 'Initialisation';
                group("Valeur Par Defaut Creation Tiers")
                {
                    Caption = 'Valeur Par Defaut Creation Tiers';
                    field("Grp Cpt Marché"; CdeGroupeComptaMarche)
                    {
                        ApplicationArea = all;
                        TableRelation = "Gen. Business Posting Group";
                    }
                    field("Grp Cpt Marché Tva"; CdeGroupeComptaMarcheTva)
                    {
                        ApplicationArea = all;
                        TableRelation = "VAT Business Posting Group";
                    }
                    field("Grp Cpt Clt"; CdeGrpCptClt)
                    {
                        ApplicationArea = all;
                        TableRelation = "Customer Posting Group";
                    }
                    field("Grp Cpt Frs"; CdeGrpCptFrs)
                    {
                        ApplicationArea = all;
                        TableRelation = "Vendor Posting Group";
                    }
                }
            }
            group("Critére Type De Comptes1")
            {
                Caption = 'Critére Type De Comptes';
                field("Type Ecriture"; OptTypeEcriture)
                {
                    ApplicationArea = all;
                }
                field(CdeCritereTypeCompte; CdeCritereTypeCompte)
                {
                    ApplicationArea = all;
                    Caption = 'Critere Compte General (Exemple 401*  Type 2 : Fournisseur , 411*  Type 1 : Client )';
                }
            }
            group("Traitement Données1")
            {
                Caption = 'Traitement Données';
                field(CdeJournalReportANouveau; CdeJournalReportANouveau)
                {
                    ApplicationArea = all;
                    Caption = 'Journal Report A Nouveau';
                }
                field(TxtFiltreClt; TxtFiltreClt)
                {
                    ApplicationArea = all;
                    Caption = 'Critére Compte Client ( Exemple 411* )';
                }
                field(TxtFiltreFrs; TxtFiltreFrs)
                {
                    ApplicationArea = all;
                    Caption = 'Critére Compte Fournisseur ( Exemple 401*  Ou 404*)';
                }
                field(TxtFiltreBanque; TxtFiltreBanque)
                {
                    ApplicationArea = all;
                    Caption = 'Critére Compte Banque ( Exemple 532* )';
                }
            }
            group("Génèration Ecritures")
            {
                Caption = 'Génèration Ecritures';
                field("Sens Debit (Exemple D)"; TxtSensDebit)
                {
                    ApplicationArea = all;
                    Caption = 'Sens Debit (Exemple D)';
                }
                field("Sens Credit (Exemple C)"; TxtSensCredit)
                {
                    ApplicationArea = all;
                }
                field("Année"; IntAnnée)
                {
                    ApplicationArea = all;
                }
                field("Model Feuille Cpta"; CdeModelFeuille)
                {
                    ApplicationArea = all;
                    TableRelation = "Gen. Journal Template";
                }
                field("Feuille Par Defaut"; CdeFeuilleParDefaut)
                {
                    ApplicationArea = all;
                    TableRelation = "Gen. Journal Batch";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RecLGenJournalBatch: Record "Gen. Journal Batch";
                    begin
                        // >> HJ DSFT 27-03-2012
                        RecLGenJournalBatch.SetRange("Journal Template Name", CdeModelFeuille);
                        if PAGE.RunModal(0, RecLGenJournalBatch) = Action::LookupOK then CdeFeuilleParDefaut := RecLGenJournalBatch.Name;
                        // >> HJ DSFT 27-03-2012
                    end;
                }
                field("Code Journal"; CdeCodeJournal)
                {
                    ApplicationArea = all;
                    TableRelation = "Source Code";
                }
                field("Utiliser Sens Ecriture"; BlnUtiliserSens)
                {
                    ApplicationArea = all;
                }
                field("Utiliser Montant Devise"; BlnUtiliserDevise)
                {
                    ApplicationArea = all;
                }
                field("Valider Ecriture En Comptabilité"; BlnValiderEcriture)
                {
                    ApplicationArea = all;
                }
            }
            repeater(Control1000000005)
            {
                Editable = true;
                ShowCaption = false;

                field("<N° Pièce>"; REC."N° Pièce")
                {
                    ApplicationArea = all;
                    Caption = 'N° Pièce';
                }
                field("<Date Ecriture>"; REC."Date Ecriture")
                {
                    ApplicationArea = all;
                    Caption = 'Date Ecriture';
                }
                field("<Type Compte>"; REC."Type Compte")
                {
                    ApplicationArea = all;
                    Caption = 'Type Compte';
                }
                field("<N° Compte Général>"; REC."N° Compte Général")
                {
                    ApplicationArea = all;
                    Caption = 'N° Compte Général';
                }
                field("<Compte Tiers>"; REC."Compte Tiers")
                {
                    ApplicationArea = all;
                    Caption = 'Compte Tiers';
                }
                field("<Compte Immo Correspond>"; REC."Compte Immo Correspond")
                {
                    ApplicationArea = all;
                    Caption = 'Compte Immo Correspond';
                }
                field("<Num Immo>"; REC."Num Immo")
                {
                    ApplicationArea = all;
                    Caption = 'Num Immo';
                }
                field("<Libellé Ecriture>"; REC."Libellé Ecriture")
                {
                    ApplicationArea = all;
                    Caption = 'Libellé Ecriture';
                }
                field("<Code Journal>"; REC."Code Journal")
                {
                    ApplicationArea = all;
                    Caption = 'Code Journal';
                }
                field("<Montant DS>"; REC."Montant DS")
                {
                    ApplicationArea = all;
                    Caption = 'Montant DS';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Mettre à Jour Type Compte")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetCurrentkey("N° Compte Général");
                    RecRecuperationHistCpta.SetFilter("N° Compte Général", CdeCritereTypeCompte);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            RecRecuperationHistCpta."Type Compte" := OptTypeEcriture;
                            RecRecuperationHistCpta.Modify;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }

            action("Appliquer Correspondnace (403,409 Et 413,419 A Tiers)")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetFilter("Compte Tiers", '<>%1', '');
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            if RecCorrespondance.Get(RecRecuperationHistCpta."Compte Tiers") then begin
                                RecRecuperationHistCpta."Compte Tiers" := RecCorrespondance."Compte Tiers Correspondant";
                                RecRecuperationHistCpta.Modify;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Appliquer Correspondnace Classe 28")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetFilter("N° Compte Général", '28*');
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            if RecCorrespondance.Get(RecRecuperationHistCpta."N° Compte Général") then begin
                                RecRecuperationHistCpta."Compte Immo Correspond" := RecCorrespondance."Compte Tiers Correspondant";
                                RecRecuperationHistCpta.Modify;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Appliquer Ancier Code Immo (Classe 22 )")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            RecFixedAsset.Reset;
                            RecFixedAsset.SetRange("Ancien Code", RecRecuperationHistCpta."N° Compte Général");
                            if RecFixedAsset.FindFirst then begin
                                RecFADepreciationBook.SetRange("FA No.", RecFixedAsset."No.");
                                if RecFADepreciationBook.FindFirst then begin
                                    if RecFAPostingGroup.Get(RecFADepreciationBook."FA Posting Group") then begin
                                        RecRecuperationHistCpta."Compte Immo Correspond" := RecFAPostingGroup."Acquisition Cost Account";
                                        RecRecuperationHistCpta."Num Immo" := RecFixedAsset."No.";
                                        RecRecuperationHistCpta.Modify;
                                    end;
                                end;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Eliminer Ecriture Journal Report A Nouveau")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    if CdeJournalReportANouveau = '' then Error(Text012);
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetRange("Code Journal", CdeJournalReportANouveau);
                    IntNomBreLignes := RecRecuperationHistCpta.Count;
                    RecRecuperationHistCpta.DeleteAll;
                    Message(Text013, IntNomBreLignes);
                end;
            }
            action("Créer  Client Inexistant")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if CdeGrpCptClt = '' then Error(Text006);
                    if CdeGroupeComptaMarche = '' then Error(Text004);
                    if CdeGroupeComptaMarcheTva = '' then Error(Text005);
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetCurrentkey("N° Compte Général");
                    RecRecuperationHistCpta.SetFilter("N° Compte Général", TxtFiltreClt);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            RecCustomer.Reset;
                            RecCustomer.SetRange("Ancien Code", RecRecuperationHistCpta."Compte Tiers");
                            if not RecCustomer.FindFirst then begin
                                if RecRecuperationHistCpta."Compte Tiers" <> '' then begin
                                    RecCustomer."No." := RecRecuperationHistCpta."Compte Tiers";
                                    RecCustomer.Name := 'Inserer Par Recuperation Hist Cpta';
                                    RecCustomer."Customer Posting Group" := CdeGrpCptClt;
                                    RecCustomer."Gen. Bus. Posting Group" := CdeGroupeComptaMarche;
                                    RecCustomer."VAT Bus. Posting Group" := CdeGroupeComptaMarcheTva;
                                    RecCustomer."Ancien Code" := RecRecuperationHistCpta."Compte Tiers";
                                    if RecCustomer.Insert then;
                                end;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Créer  Fournisseur Inexistant")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if CdeGrpCptFrs = '' then Error(Text003);
                    if CdeGroupeComptaMarche = '' then Error(Text004);
                    if CdeGroupeComptaMarcheTva = '' then Error(Text005);
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Reset;
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetCurrentkey("N° Compte Général");
                    RecRecuperationHistCpta.SetFilter("N° Compte Général", TxtFiltreFrs);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            RecVendor.Reset;
                            RecVendor.SetRange("Ancien Numero", RecRecuperationHistCpta."Compte Tiers");
                            if not RecVendor.FindFirst then begin
                                if RecRecuperationHistCpta."Compte Tiers" <> '' then begin
                                    RecVendor."No." := RecRecuperationHistCpta."Compte Tiers";
                                    RecVendor.Name := 'Inserer Par Recuperation Hist Cpta';
                                    RecVendor."Vendor Posting Group" := CdeGrpCptFrs;
                                    RecVendor."Gen. Bus. Posting Group" := CdeGroupeComptaMarche;
                                    RecVendor."VAT Bus. Posting Group" := CdeGroupeComptaMarcheTva;
                                    RecVendor."Ancien Numero" := RecRecuperationHistCpta."Compte Tiers";
                                    if RecVendor.Insert then;
                                end;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Créer Banque Inexistant")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    RecRecuperationHistCpta.SetCurrentkey("N° Compte Général");
                    RecRecuperationHistCpta.SetFilter("N° Compte Général", TxtFiltreBanque);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            RecBankAccount.Reset;
                            RecBankAccount.SetRange("Ancien Code", RecRecuperationHistCpta."N° Compte Général");
                            if not RecBankAccount.FindFirst then begin
                                RecBankAccount."No." := RecRecuperationHistCpta."N° Compte Général";
                                RecBankAccount.Name := 'Inserer Par Recuperation Hist Cpta';
                                RecBankAccount."Bank Acc. Posting Group" := RecRecuperationHistCpta."N° Compte Général";
                                RecBankAccountPostingGroup.Code := RecRecuperationHistCpta."N° Compte Général";
                                RecBankAccountPostingGroup."G/L Account No." := RecRecuperationHistCpta."N° Compte Général";
                                RecBankAccountPostingGroup.Insert;
                                if RecBankAccountPostingGroup.Insert then;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Créer  Journal Inexistant")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            if not RecSourceCode.Get(RecRecuperationHistCpta."Code Journal") then begin
                                RecSourceCode.Code := RecRecuperationHistCpta."Code Journal";
                                RecSourceCode.Description := 'Inserer Par Recuperation Hist Cpta';
                                RecSourceCode.Insert;
                            end;
                        until RecRecuperationHistCpta.Next = 0;
                    Message(Text002);
                end;
            }
            action("Créer  Compte Génèral Inexistant")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if not Confirm(Text001) then exit;
                    RecRecuperationHistCpta.Copy(Rec);
                    if RecRecuperationHistCpta.FindFirst then
                        repeat
                            if not RecGLAccount.Get(RecRecuperationHistCpta."N° Compte Général") then begin
                                if (CopyStr(RecRecuperationHistCpta."N° Compte Général", 1, 1) = '6') or
                                (CopyStr(RecRecuperationHistCpta."N° Compte Général", 1, 1) = '7') then begin
                                    RecGLAccount."No." := RecRecuperationHistCpta."N° Compte Général";
                                    RecGLAccount.Name := 'Recuperation Hist Cpta';
                                    RecGLAccount."Income/Balance" := 1;
                                    RecGLAccount."Income/Balance" := 0;
                                    RecGLAccount.Insert;
                                end;
                                if (CopyStr(RecRecuperationHistCpta."N° Compte Général", 1, 1) = '2') and
                                    (RecRecuperationHistCpta."Compte Immo Correspond" = '') then begin
                                    CdeCompte := CopyStr(RecRecuperationHistCpta."N° Compte Général", 1, 3) + '00000';
                                    if not RecGLAccount2.Get(CdeCompte) then
                                        CdeCompte := CopyStr(RecRecuperationHistCpta."N° Compte Général", 1, 2) + '000000';

                                    RecRecuperationHistCpta."N° Compte Général" := CdeCompte;
                                    RecGLAccount."No." := CdeCompte;
                                    RecGLAccount.Name := 'Recuperation Hist Cpta';
                                    RecGLAccount."Income/Balance" := 1;
                                    RecGLAccount."Income/Balance" := 0;
                                    if RecGLAccount.Insert then;
                                    RecRecuperationHistCpta."N° Compte Général" := CdeCompte;
                                    RecRecuperationHistCpta.Modify;
                                end;

                            end;
                            if (RecRecuperationHistCpta."Compte Immo Correspond" <> '') then begin
                                if not RecGLAccount.Get(RecRecuperationHistCpta."Compte Immo Correspond") then begin
                                    CdeCompte := CopyStr(RecRecuperationHistCpta."Compte Immo Correspond", 1, 3) + '00000';
                                    if not RecGLAccount2.Get(CdeCompte) then
                                        CdeCompte := CopyStr(RecRecuperationHistCpta."Compte Immo Correspond", 1, 2) + '000000';

                                    RecRecuperationHistCpta."N° Compte Général" := CdeCompte;
                                    RecGLAccount."No." := CdeCompte;
                                    RecGLAccount.Name := 'Recuperation Hist Cpta';
                                    RecGLAccount."Income/Balance" := 1;
                                    RecGLAccount."Income/Balance" := 0;
                                    if RecGLAccount.Insert then;
                                    RecRecuperationHistCpta."N° Compte Général" := CdeCompte;
                                    RecRecuperationHistCpta.Modify;
                                end;
                            end;
                        until RecRecuperationHistCpta.Next = 0;


                    Message(Text002);
                end;
            }

            action("Integrer Ecritures Dans Feuille Comptable")
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if IntAnnée = 0 then Error(Text009);
                    DteDateDebut := Dmy2date(1, 1, IntAnnée);
                    DteDateFin := Dmy2date(31, 12, IntAnnée);

                    if BlnUtiliserSens then begin
                        if TxtSensDebit = '' then Error(Text007);
                        if TxtSensCredit = '' then Error(Text008);
                    end;
                    if (CdeModelFeuille = '') or (CdeFeuilleParDefaut = '') then Error(Text010);
                    if not Confirm(Text001) then exit;
                    if CdeCodeJournal <> '' then RecSourceCode.SetRange(Code, CdeCodeJournal);
                    if RecSourceCode.FindFirst then
                        repeat

                            RecRecuperationHistCpta.Reset;
                            RecRecuperationHistCpta.Copy(Rec);
                            RecRecuperationHistCpta.SetCurrentkey("Code Journal", "Date Ecriture", "N° Pièce", "N° Compte Général");
                            RecRecuperationHistCpta.SetRange("Date Ecriture", DteDateDebut, DteDateFin);
                            RecRecuperationHistCpta.SetRange("Code Journal", RecSourceCode.Code);
                            RecGenJournalLine.SetRange("Journal Template Name", CdeModelFeuille);
                            RecGenJournalLine.SetRange("Journal Batch Name", CdeFeuilleParDefaut);
                            RecGenJournalLine.DeleteAll;
                            if RecRecuperationHistCpta.FindFirst then
                                repeat
                                    IntNumLigne += 10;
                                    RecGenJournalLine."Journal Template Name" := CdeModelFeuille;
                                    RecGenJournalLine."Journal Batch Name" := CdeFeuilleParDefaut;
                                    RecGenJournalLine."Line No." := IntNumLigne;

                                    /// Debut Partie Compte General Et Compte Bancaire
                                    if RecRecuperationHistCpta."Compte Tiers" = '' then begin

                                        if (RecRecuperationHistCpta."Type Compte" = 0) and (RecRecuperationHistCpta."Compte Immo Correspond" = '') then begin

                                            RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"G/L Account");
                                            RecGenJournalLine.Validate("Account No.", RecRecuperationHistCpta."N° Compte Général");
                                        end;
                                        if (RecRecuperationHistCpta."Type Compte" = 3) and (RecRecuperationHistCpta."Compte Immo Correspond" = '') then begin
                                            RecBankAccount.Reset;
                                            RecBankAccount.SetRange("Ancien Code", RecRecuperationHistCpta."N° Compte Général");
                                            if RecBankAccount.FindFirst then begin
                                                RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"Bank Account");
                                                RecGenJournalLine.Validate("Account No.", RecBankAccount."No.");
                                            end
                                            else begin
                                                if (RecRecuperationHistCpta."Compte Immo Correspond" = '') then begin
                                                    RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"G/L Account");
                                                    RecGenJournalLine.Validate("Account No.", RecRecuperationHistCpta."N° Compte Général");
                                                end;
                                            end;
                                        end;
                                        if RecRecuperationHistCpta."Compte Immo Correspond" <> '' then begin
                                            RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"G/L Account");
                                            RecGenJournalLine.Validate("Account No.", RecRecuperationHistCpta."Compte Immo Correspond");
                                            if RecRecuperationHistCpta."Num Immo" <> '' then begin
                                                RecGenJournalLine.Validate("Source Type", RecGenJournalLine."source type"::"Fixed Asset");
                                                RecGenJournalLine.Validate("Source No.", RecRecuperationHistCpta."Num Immo");
                                            end;

                                        end;

                                    end;
                                    /// Fin Partie Compte General Et Compte Bancaire

                                    /// **** Debut Partie Compte Tiers
                                    if RecRecuperationHistCpta."Compte Tiers" <> '' then begin
                                        if CopyStr(RecRecuperationHistCpta."N° Compte Général", 1, 3) = CopyStr(RecRecuperationHistCpta."Compte Tiers", 1, 3) then begin
                                            RecCustomer.Reset;
                                            RecVendor.Reset;
                                            RecCustomer.SetRange("Ancien Code", RecRecuperationHistCpta."Compte Tiers");
                                            RecVendor.SetRange("Ancien Numero", RecRecuperationHistCpta."Compte Tiers");
                                            if RecCustomer.FindFirst then begin
                                                RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::Customer);
                                                RecGenJournalLine.Validate("Account No.", RecCustomer."No.");
                                            end
                                            else begin
                                                RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"G/L Account");
                                                RecGenJournalLine.Validate("Account No.", RecRecuperationHistCpta."N° Compte Général");

                                            end;
                                            if RecVendor.FindFirst then begin
                                                RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::Vendor);
                                                RecGenJournalLine.Validate("Account No.", RecVendor."No.");
                                            end
                                            else begin
                                                RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"G/L Account");
                                                RecGenJournalLine.Validate("Account No.", RecRecuperationHistCpta."N° Compte Général");

                                            end;
                                        end
                                        else  // Debut  Compte Avec Type Origine Et N° Origine
                                          begin
                                            RecGenJournalLine.Validate("Account Type", RecGenJournalLine."account type"::"G/L Account");
                                            RecGenJournalLine.Validate("Account No.", RecRecuperationHistCpta."N° Compte Général");
                                            RecCustomer.Reset;
                                            RecVendor.Reset;
                                            RecCustomer.SetRange("Ancien Code", RecRecuperationHistCpta."Compte Tiers");
                                            RecVendor.SetRange("Ancien Numero", RecRecuperationHistCpta."Compte Tiers");

                                        end;
                                        if RecCustomer.FindFirst then begin
                                            RecGenJournalLine.Validate("Source Type", RecGenJournalLine."source type"::Customer);
                                            RecGenJournalLine.Validate("Source No.", RecCustomer."No.");
                                        end;
                                        if RecVendor.FindFirst then begin
                                            RecGenJournalLine.Validate("Source Type", RecGenJournalLine."source type"::Vendor);
                                            RecGenJournalLine.Validate("Source No.", RecVendor."No.");
                                        end;
                                        // Fin  Compte Avec Type Origine Et N° Origine
                                    end;
                                    /// *** Fin Compte Tiers


                                    RecGenJournalLine.Validate("Posting Date", RecRecuperationHistCpta."Date Ecriture");
                                    RecGenJournalLine."Document No." := RecRecuperationHistCpta."N° Pièce";
                                    if BlnUtiliserSens then begin
                                        if RecRecuperationHistCpta."Débit / Crédit" = TxtSensDebit then
                                            RecGenJournalLine.Validate(Amount, RecRecuperationHistCpta."Montant DS");
                                        if RecRecuperationHistCpta."Débit / Crédit" = TxtSensCredit then
                                            RecGenJournalLine.Validate(Amount, -RecRecuperationHistCpta."Montant DS");
                                    end
                                    else
                                        RecGenJournalLine.Validate(Amount, RecRecuperationHistCpta."Montant DS");
                                    if RecRecuperationHistCpta.Devise <> '' then begin
                                        if BlnUtiliserDevise then begin
                                            RecGenJournalLine.Validate("Currency Code", RecRecuperationHistCpta.Devise);
                                            RecGenJournalLine.Validate(Amount, RecRecuperationHistCpta."Montant Devise");
                                            RecGenJournalLine.Validate("Amount (LCY)", RecRecuperationHistCpta."Montant DS");
                                        end;
                                    end;
                                    RecGenJournalLine.Validate("Source Code", RecRecuperationHistCpta."Code Journal");
                                    RecGenJournalLine.Description := RecRecuperationHistCpta."Libellé Ecriture";
                                    RecGenJournalLine."Gen. Bus. Posting Group" := '';
                                    RecGenJournalLine."Gen. Prod. Posting Group" := '';
                                    RecGenJournalLine."VAT Bus. Posting Group" := '';
                                    RecGenJournalLine."VAT Prod. Posting Group" := '';
                                    RecGenJournalLine."Gen. Posting Type" := 0;
                                    RecGenJournalLine.Validate("Currency Code", '');
                                    RecGenJournalLine.Insert;
                                until RecRecuperationHistCpta.Next = 0;
                            RecGenJournalLine2.Copy(RecGenJournalLine);
                            if RecGenJournalLine2.Count > 0 then begin
                                Message(Text011, RecSourceCode.Code);
                                RecGenJournalLine.SetCurrentkey("Source Code", "Document No.", "Posting Date");
                                if BlnValiderEcriture then Codeunit.Run(Codeunit::"Gen. Jnl.-Post", RecGenJournalLine);
                            end;
                        until RecSourceCode.Next = 0;
                    Message(Text002);
                end;
            }
            action(Purger)
            {
                ApplicationArea = all;

                trigger OnAction()
                begin
                    if IntAnnée = 0 then Error(Text009);
                    DteDateDebut := Dmy2date(1, 1, IntAnnée);
                    DteDateFin := Dmy2date(31, 12, IntAnnée);
                    // Purge Des Données
                    RecGLEntry.SetRange("Posting Date", DteDateDebut, DteDateFin);
                    RecCustLedgerEntry.SetRange("Posting Date", DteDateDebut, DteDateFin);
                    RecVendorLedgerEntry.SetRange("Posting Date", DteDateDebut, DteDateFin);
                    RecDetailedCustLedgEntry.SetRange("Posting Date", DteDateDebut, DteDateFin);
                    RecDetailedVendorLedgEntry.SetRange("Posting Date", DteDateDebut, DteDateFin);
                    RecBankAccountLedgerEntry.SetRange("Posting Date", DteDateDebut, DteDateFin);
                    RecGLEntry.DeleteAll;
                    RecCustLedgerEntry.DeleteAll;
                    RecVendorLedgerEntry.DeleteAll;
                    RecDetailedCustLedgEntry.DeleteAll;
                    RecDetailedVendorLedgEntry.DeleteAll;
                    RecBankAccountLedgerEntry.DeleteAll;
                    // Fin Purge
                end;
            }


        }
    }

    trigger OnOpenPage()
    begin
        REC.SetCurrentkey("Code Journal", "Date Ecriture", "N° Pièce", "N° Compte Général");
    end;

    var
        RecSourceCode: Record "Source Code";
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
        RecBankAccount: Record "Bank Account";
        RecRecuperationHistCpta: Record "Recuperation Historique";
        RecRecuperationHistCpta2: Record "Recuperation Historique";
        RecBankAccountPostingGroup: Record "Bank Account Posting Group";
        ReItemJournalBatch: Record "Item Journal Batch";
        RecGenJournalLine: Record "Gen. Journal Line";
        RecGenJournalLine2: Record "Gen. Journal Line";
        RecGLAccount2: Record "G/L Account";
        RecGLAccount: Record "G/L Account";
        RecCorrespondance: Record Correspondance;
        // RecSolderPieceIncorrect: Record tempo01;
        RecGLEntry: Record "G/L Entry";
        RecCustLedgerEntry: Record "Cust. Ledger Entry";
        RecVendorLedgerEntry: Record "Vendor Ledger Entry";
        RecDetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        RecDetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        RecBankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        TxtSensDebit: Text[10];
        TxtSensCredit: Text[10];
        "IntAnnée": Integer;
        DteDateDebut: Date;
        DteDateFin: Date;
        CdeGroupeComptaMarche: Code[20];
        CdeGroupeComptaMarcheTva: Code[20];
        CdeGrpCptFrs: Code[10];
        CdeGrpCptClt: Code[20];
        CdeModelFeuille: Code[20];
        CdeFeuilleParDefaut: Code[20];
        CdeCritereTypeCompte: Code[10];
        TxtFiltreClt: Text[30];
        TxtFiltreFrs: Text[30];
        TxtFiltreBanque: Text[30];
        OptTypeEcriture: Option General,Client,Fournisseur,Banque;
        IntNumLigne: Integer;
        CdeCodeJournal: Code[20];
        BlnValiderEcriture: Boolean;
        BlnUtiliserSens: Boolean;
        BlnUtiliserDevise: Boolean;
        RecFAPostingGroup: Record "FA Posting Group";
        RecFixedAsset: Record "Fixed Asset";
        RecFADepreciationBook: Record "FA Depreciation Book";
        CdeJournalReportANouveau: Code[20];
        IntNomBreLignes: Integer;
        CdeCompte: Code[10];
        Text001: label 'Lancer Cette Action ?';
        Text002: label 'Action Achevée';
        Text003: label 'Preciser Groupe Compta Fournisseur';
        Text004: label 'Preciser Groupe Compta Marché';
        Text005: label 'Preciser Groupe Compta Marché TVA';
        Text006: label 'Preciser Groupe Compta Client';
        Text007: label 'Preciser Sens Debit';
        Text008: label 'Preciser Sens Credit';
        Text009: label 'Preciser Année';
        Text010: label 'Preciser Journal';
        Text011: label 'Validation Du Journal N° %1';
        Text012: label 'Veuillez Spécifier Le Code Journal';
        Text013: label '%1 Lignes Supprimées';
}

