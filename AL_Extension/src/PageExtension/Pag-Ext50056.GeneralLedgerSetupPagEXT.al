PageExtension 50056 "General Ledger Setup_PagEXT" extends "General Ledger Setup"
{
    layout
    {
        addafter("Print VAT specification in LCY")
        {
            field("Unit-Amount Decimal Places"; Rec."Unit-Amount Decimal Places")
            {
                ApplicationArea = all;
            }
            field("Unit-Amount Rounding Precision"; Rec."Unit-Amount Rounding Precision")
            {
                ApplicationArea = all;
            }

            field("Sales Unit-Amt Round. Prec."; Rec."Sales Unit-Amt Round. Prec.")
            {
                ApplicationArea = all;
            }
            field("Amount Decimal Places"; Rec."Amount Decimal Places")
            {
                ApplicationArea = all;
            }
            field("Amount Rounding Precision"; Rec."Amount Rounding Precision")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bank Account Nos.")
        {
            field("Souche Bureau Ordre"; Rec."Souche Bureau Ordre")
            {
                ApplicationArea = all;
            }
            field("Chemin Bureau Ordre"; Rec."Chemin Bureau Ordre")
            {
                ApplicationArea = all;
            }
            /* field("Souche Retenue Source"; Rec."Souche Retenue Source")
             {
                 ApplicationArea = all;
             }
             field("Souche Credit"; Rec."Souche Credit")
             {
                 ApplicationArea = all;
             }*/
        }
        addafter("Max. Payment Tolerance Amount")
        {
            field("Utilisateur Extra"; rec."Utilisateur Extra")
            {
                ApplicationArea = all;
            }
            field("Caisse EXT"; Rec."Caisse EXT")
            {
                ApplicationArea = all;
            }
            field("Type Reg. Caisse Ext"; Rec."Type Reg. Caisse Ext")
            {
                ApplicationArea = all;
            }
            field("Type Reg. Caisse Cpt"; Rec."Type Reg. Caisse Cpt")
            {
                ApplicationArea = all;
            }
        }
        addafter(Application)
        {


            group(Payment)
            {
                Caption = 'Payment';
                field("Bank Waiting Period"; rec."Bank Waiting Period")
                {
                    ApplicationArea = all;
                }
                field("Cash Hand. Reason Code"; rec."Cash Hand. Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Discount Hand. Reason Code"; rec."Discount Hand. Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Picture No."; rec."Picture No.")
                {
                    ApplicationArea = all;
                }
                field("Check Text"; rec."Check Text")
                {
                    ApplicationArea = all;
                }
                field("Bill Text"; rec."Bill Text")
                {
                    ApplicationArea = all;
                }
                field("Transfer Text"; rec."Transfer Text")
                {
                    ApplicationArea = all;
                }
                field("Direct Debit Text"; rec."Direct Debit Text")
                {
                    ApplicationArea = all;
                }
                field("Credit Card Text"; rec."Credit Card Text")
                {
                    ApplicationArea = all;
                }
                field("VCOM Text"; rec."VCOM Text")
                {
                    ApplicationArea = all;
                }
                field("Check Footer Text"; rec."Check Footer Text")
                {
                    ApplicationArea = all;
                }
                field("Bill Footer Text"; rec."Bill Footer Text")
                {
                    ApplicationArea = all;
                }
                field("Transfer Footer Text"; rec."Transfer Footer Text")
                {
                    ApplicationArea = all;
                }
                field("Direct Debit Footer Text"; rec."Direct Debit Footer Text")
                {
                    ApplicationArea = all;
                }
                field("Credit Card Footer Text"; rec."Credit Card Footer Text")
                {
                    ApplicationArea = all;
                }
                field("VCOM Footer Text"; rec."VCOM Footer Text")
                {
                    ApplicationArea = all;
                }
                field("Local Currency2"; rec."Local Currency")
                {
                    ApplicationArea = all;
                }
                field("Currency Euro2"; rec."Currency Euro")
                {
                    ApplicationArea = all;
                }
            }
            group(Location)
            {
                Caption = 'Location';
                field(Localization; rec.Localization)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        lShowLocalization(rec.Localization);
                    end;
                }
                group(Belgium)
                {
                    Visible = frmBEVISIBLE;
                    Caption = 'Belgium';
                    field("VAT Statement Template Name"; rec."VAT Statement Template Name")
                    {

                        ApplicationArea = all;
                    }
                    field("VAT Statement Name"; rec."VAT Statement Name")
                    {

                        ApplicationArea = all;
                    }
                    field("XML Seq. No. VAT Declaration"; rec."XML Seq. No. VAT Declaration")
                    {
                        ApplicationArea = all;
                    }
                }
            }
            group("Synchronisation")
            {
                Caption = 'Synchronisation';
                field("Données Administration"; rec."Données Administration")
                {
                    ApplicationArea = all;
                }
                field("Données Chantier"; rec."Données Chantier")
                {
                    ApplicationArea = all;
                }
                field("Erreur Administration"; rec."Erreur Administration")
                {
                    ApplicationArea = all;
                }
                field("Erreur Chantier"; rec."Erreur Chantier")
                {
                    ApplicationArea = all;
                }
                field("Modèle Feuille Pull"; rec."Modèle Feuille Pull")
                {
                    ApplicationArea = all;
                }
                field("Nom Feuille Pull"; rec."Nom Feuille Pull")
                {
                    ApplicationArea = all;
                }
                field("Numero Affaire Interne"; rec."Numero Affaire Interne")
                {
                    ApplicationArea = all;
                }
                group(Divers)
                {
                    Caption = 'Divers';
                    field("Journal Batch Echeance"; rec."Journal Batch Echeance")
                    {
                        ApplicationArea = all;
                    }
                    field("Journal Template Echeance"; rec."Journal Template Echeance")
                    {
                        ApplicationArea = all;
                    }
                    field("Compte Credit"; rec."Compte Credit")
                    {
                        ApplicationArea = all;
                    }
                    field("Compte Charge Credit"; rec."Compte Charge Credit")
                    {
                        ApplicationArea = all;
                    }
                    field("Compte Principal"; rec."Compte Principal")
                    {
                        ApplicationArea = all;
                    }
                    field("Compte Interet"; rec."Compte Interet")
                    {
                        ApplicationArea = all;
                    }


                    field("Type Caisse CPT"; rec."Type Caisse CPT")
                    {
                        ApplicationArea = all;
                    }
                    field("Type Alim. Caisse"; rec."Type Alim. Caisse")
                    {
                        ApplicationArea = all;
                    }
                    field("Souche Paiement En Lot"; rec."Souche Paiement En Lot")
                    {
                        ApplicationArea = all;
                    }
                    field("Mode Regelement Paiement"; rec."Mode Regelement Paiement")
                    {
                        ApplicationArea = all;
                    }

                    field("Utiliser Update Code Nature"; rec."Utiliser Update Code Nature")
                    {
                        ApplicationArea = all;
                    }
                    /*    field("No. Compte Rapp 1"; rec."No. Compte Rapp 1")
                        {
                            ApplicationArea = all;
                        }
                        field("No. Compte Rapp 2"; rec."No. Compte Rapp 2")
                        {
                            ApplicationArea = all;
                        }
                        field("No. Compte Rapp 3"; rec."No. Compte Rapp 3")
                        {
                            ApplicationArea = all;
                        }
                        field("No. Compte Rapp 4"; rec."No. Compte Rapp 4")
                        {
                            ApplicationArea = all;
                        }
                        field("No. Compte Rapp 5"; rec."No. Compte Rapp 5")
                        {
                            ApplicationArea = all;
                        }
                        field("Activer Rapproch. Auto"; rec."Activer Rapproch. Auto")
                        {
                            ApplicationArea = all;
                        }
                        field("Date Debut Lettarge Auto"; rec."Date Debut Lettarge Auto")
                        {
                            ApplicationArea = all;
                        }
                        field("N° Caution Provisoire"; rec."N° Caution Provisoire")
                        {
                            ApplicationArea = all;
                        }
                        field("N° Caution Definitive"; rec."N° Caution Definitive")
                        {
                            ApplicationArea = all;
                        }
                        field("N° Caution Garantie"; rec."N° Caution Garantie")
                        {
                            ApplicationArea = all;
                        }
                        field("N° Caution Avance"; rec."N° Caution Avance")
                        {
                            ApplicationArea = all;
                        }
                        field("N° Caution Approvisionnement"; rec."N° Caution Approvisionnement")
                        {
                            ApplicationArea = all;
                        }
                        field("N° Caution Solidaire"; rec."N° Caution Solidaire")
                        {
                            ApplicationArea = all;
                        }*/
                }
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action("...")
            {
                Caption = '...';
                ApplicationArea = all;

                trigger OnAction()
                var
                    FileName: Text[250];
                    lFilename: Text[1024];
                    Text001: label 'Select a folder';
                    Text002: label 'All files (*.*)|*.*';
                    Text003: label 'Select a file';
                //GL2024 N'existe pas  ComDlgMngt: Codeunit 412;
                begin


                    // HJ DSFT 03-07-2012
                    //GL2024  FileName := ComDlgMngt.OpenFile(Text001, lFilename, 4, Text002, 2);
                    rec."Chemin Bureau Ordre" := FileName;
                    rec.MODIFY;
                    // HJ DSFT 03-07-2012

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //+PMT+Localization
        lShowLocalization(rec.Localization);
        //+PMT+Localization//
    end;

    local procedure lShowLocalization(pLocalization: Integer)
    begin

        //+PMT+Localization
        frmFRVISIBLE := (pLocalization = rec.Localization::FR);
        frmBEVISIBLE := (pLocalization = rec.Localization::BE);
        frmCHVISIBLE := (pLocalization = rec.Localization::CH);
        frmESVISIBLE := (pLocalization = rec.Localization::ES);
        //+PMT+Localization//


    end;

    var
        //GL2024
        frmFRVISIBLE: Boolean;
        frmBEVISIBLE: Boolean;
        frmCHVISIBLE: Boolean;
        frmESVISIBLE: Boolean;
}

