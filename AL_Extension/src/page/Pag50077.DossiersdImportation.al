page 50077 "Dossiers d'Importation"
{
    PageType = Card;
    SourceTable = "Dossiers d'Importation";
    Caption = 'Dossiers d''Importation';
    //HS // ApplicationArea = all;
    //HS // UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'General';
                group(Fournisseur)
                {
                    Caption = 'Vendor';
                    field("N° Dossier"; rec."N° Dossier")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("N° Fournisseur"; rec."N° Fournisseur")
                    {
                        ApplicationArea = all;
                    }
                    field("Nom fournisseur"; rec."Nom fournisseur")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(Addresse; rec.Addresse)
                    {
                        ApplicationArea = all;
                    }
                    field("Addresse 2"; rec."Addresse 2")
                    {
                        ApplicationArea = all;
                    }
                    field(Ville; rec.Ville)
                    {
                        ApplicationArea = all;
                    }
                    field("Code postale"; rec."Code postale")
                    {
                        ApplicationArea = all;
                    }
                }
                field("N° Facture fournisseur"; rec."N° Facture fournisseur")
                {
                    ApplicationArea = all;
                }
                field(Colisage1; rec.Colisage1)
                {
                    ApplicationArea = all;
                }
                field(Colisage2; rec.Colisage2)
                {
                    ApplicationArea = all;
                }
                field(Colisage3; rec.Colisage3)
                {
                    ApplicationArea = all;
                }
                field("N° Transitaire"; rec."N° Transitaire")
                {
                    ApplicationArea = all;
                }
                field("Nom Transitaire"; rec."Nom Transitaire")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Gain de change"; rec."Gain de change")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Perte de change"; rec."Perte de change")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date d'ouverture"; rec."Date d'ouverture")
                {
                    ApplicationArea = all;
                }
                field("Date de clôture"; rec."Date de clôture")
                {
                    ApplicationArea = all;
                }
                field("Date Déclaration"; rec."Date Déclaration")
                {
                    ApplicationArea = all;
                }
                field("N° dern Commande"; rec."N° dern Commande")
                {
                    ApplicationArea = all;
                    TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
                }
                field(Montant; rec.Montant)
                {
                    ApplicationArea = all;
                }
                field("Montant (dev Soc)"; rec."Montant (dev Soc)")
                {
                    ApplicationArea = all;
                }
                field(FraisApproche; rec.FraisApproche)
                {
                    ApplicationArea = all;
                    Caption = '% Frais d''approche';
                    Editable = false;
                }
                field("%FretM"; rec."%FretM")
                {
                    ApplicationArea = all;
                    Caption = '% Frais de Frèt';
                    Editable = false;
                }
                field(Statut; rec.Statut)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("N° Titre d'importation"; rec."N° Titre d'importation")
                {
                    ApplicationArea = all;
                }
                field("Date Titre d'importation"; rec."Date Titre d'importation")
                {
                    ApplicationArea = all;
                }
                field("Marge sur Vente"; rec."Marge sur Vente")
                {
                    ApplicationArea = all;
                }
                field("Facteur Devise"; rec."Facteur Devise")
                {
                    ApplicationArea = all;
                }
            }
            part("Lignes Dossiers d'Importation"; "Lignes Dossiers d'Importation")
            {
                ApplicationArea = all;
                Editable = true;
                Enabled = true;
                Caption = 'Import folder Lines';
                SubPageLink = "N° dossier" = FIELD("N° Dossier");
            }
            group(" Frais Provisoires")
            {
                Caption = ' Frais Provisoires';
                part("Affectation Frais Annexes"; "Affectation Frais Annexes")
                {
                    Caption = '"Allocation of item charge';
                    SubPageLink = "N° Dossier" = FIELD("N° Dossier");
                }
            }
            group("Frais validés")
            {
                Caption = 'Frais validés';
                part("Frais Validés1"; "Frais Validés")
                {
                    ApplicationArea = all;
                    SubPageLink = "N° Dossier" = FIELD("N° Dossier");
                }
            }
        }
    }

    actions
    {
        area(Promoted)
        {
            group("&Fonction1")
            {
                Caption = '&Fonction';
                actionref("&Dossier En attente1"; "&Dossier En attente") { }
                actionref("&Facturer Dossier1"; "&Facturer Dossier") { }
                actionref("&Clôturer Dossier1"; "&Clôturer Dossier") { }
                actionref("Actualiser Taux de Change1"; "Actualiser Taux de Change") { }
            }
            group(Dossier1)
            {
                Caption = 'Dossier';
                actionref("&Contenu Dossier d'Importation1"; "&Contenu Dossier d'Importation") { }
            }
            actionref("Actualiser Prix1"; "Actualiser Prix") { }
        }
        area(navigation)
        {
            group("&Fonction")
            {
                Caption = '&Fonction';
                action("&Dossier En attente")
                {
                    ApplicationArea = all;
                    Caption = '&Dossier En attente';
                    Visible = false;

                    trigger OnAction()
                    var
                        NDossier: Record "Dossiers d'Importation";
                    begin
                        NDossier.RESET;
                        NDossier.SETFILTER("N° Dossier", rec."N° Dossier");
                        IF NDossier.FIND('-') THEN
                            NDossier.VALIDATE(NDossier.Statut, 1);
                    end;
                }
                action("&Facturer Dossier")
                {
                    ApplicationArea = all;
                    Caption = '&Facturer Dossier';
                    Visible = false;

                    trigger OnAction()
                    begin
                        NDossier.RESET;
                        NDossier.SETFILTER("N° Dossier", rec."N° Dossier");
                        IF NDossier.FIND('-') THEN
                            NDossier.VALIDATE(NDossier.Statut, 2);
                    end;
                }
                action("&Clôturer Dossier")
                {
                    ApplicationArea = all;
                    Caption = '&Clôturer Dossier';

                    trigger OnAction()
                    begin
                        NDossier.RESET;
                        NDossier.SETFILTER("N° Dossier", rec."N° Dossier");
                        IF NDossier.FIND('-') THEN BEGIN
                            NDossier.VALIDATE(NDossier.Statut, 3);
                            CurrPage.EDITABLE(FALSE);
                        END;
                    end;
                }
                separator(separator100)
                {
                }
                action("Actualiser Taux de Change")
                {
                    ApplicationArea = all;
                    Caption = 'Actualiser Taux de Change';

                    trigger OnAction()
                    begin
                        rec.RecalculerCoût();
                    end;
                }
            }
            group(Dossier)
            {
                Caption = 'Dossier';
                action("&Contenu Dossier d'Importation")
                {
                    ApplicationArea = all;
                    Caption = '&Contenu Dossier d''Importation';

                    trigger OnAction()
                    var
                        NDossier: Record "Dossiers d'Importation";
                    begin
                        NDossier.RESET;
                        NDossier.SETFILTER("N° Dossier", rec."N° Dossier");
                        IF NDossier.FIND('-') THEN
                            // OLD REPORT.RUNMODAL(50111,TRUE,FALSE,NDossier);
                            REPORT.RUNMODAL(50111, TRUE, FALSE, NDossier);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Actualiser Prix")
            {
                ApplicationArea = all;
                Caption = 'Actualiser Prix ';


                trigger OnAction()
                begin
                    //IBK DSFT 04 01 2012
                    RecLigneDossiersImportation1.RESET;
                    RecLigneDossiersImportation1.SETRANGE("N° dossier", rec."N° Dossier");
                    IF RecLigneDossiersImportation1.FIND('-') THEN
                        REPEAT
                            DecCout := 0;
                            RecEcrValeur.SETRANGE("N° Dossier", rec."N° Dossier");
                            RecEcrValeur.SETRANGE("Item No.", RecLigneDossiersImportation1."N° article");

                            IF RecEcrValeur.FINDFIRST THEN
                                REPEAT
                                    IF RecEcrValeur."Item Charge No." = '' THEN
                                        DecCout := DecCout + RecEcrValeur."Cost Amount (Actual)"
                                    ELSE
                                        IF Rec5800.GET(RecEcrValeur."Item Charge No.") THEN
                                            IF Rec5800."Affect Frais Annexe" THEN
                                                DecCout := DecCout + RecEcrValeur."Cost Amount (Actual)";
                                UNTIL RecEcrValeur.NEXT = 0;

                            IF RecLigneDossiersImportation1."Quantité (base)" <> 0 THEN
                                DecCout := DecCout / RecLigneDossiersImportation1."Quantité (base)";

                        //MESSAGE(FORMAT(DecCout));
                        /*
                     RecEcrValeur.SETRANGE("N° Dossier","N° Dossier");
                     RecEcrValeur.SETRANGE("Item No.",RecLigneDossiersImportation1."N° article");
                     RecEcrValeur.SETFILTER("Item Charge No.",'%1','');
                     IF RecEcrValeur.FINDFIRST THEN
                     REPEAT
                       RecEcrValeur."Marge Previsionnelle":="Marge sur Vente";
                       RecEcrValeur."Prix de Vente Previsionnel":=DecCout+
                       DecCout*RecEcrValeur."Marge Previsionnelle"/100;
                       RecEcrValeur.MODIFY;
                       //MESSAGE(FORMAT(RecEcrValeur."Prix de Vente Previsionnel"));
                     UNTIL RecEcrValeur.NEXT=0;
                          */
                        UNTIL RecLigneDossiersImportation1.NEXT = 0;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF rec.Statut = rec.Statut::Clôturé THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

    trigger OnOpenPage()
    begin
        IF rec.Statut = rec.Statut::Clôturé THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := TRUE;
    end;

    var
        NDossier: Record "Dossiers d'Importation";
        RecEcrValeur: Record "Value Entry";
        RecEcArticle: Record "Item Ledger Entry";
        Rep795: Report "Adjust Cost - Item Entries";
        ItemFilter: Text[250];
        RecLigneDossiersImportation: Record "Ligne Dossiers d'Importation";
        Rec5800: Record "Item Charge";
        DecCout: Decimal;
        RecLigneDossiersImportation1: Record "Ligne Dossiers d'Importation";
}

