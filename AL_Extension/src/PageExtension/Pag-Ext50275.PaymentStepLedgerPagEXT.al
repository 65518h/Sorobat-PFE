PageExtension 50275 "Payment Step Ledger_PagEXT" extends "Payment Step Ledger"
{
    layout
    {
        addafter("Document No.")
        {
            field("Compta montant intial"; rec."Compta montant intial")
            {
                ApplicationArea = all;
            }
            group("Retenues et Commissions")
            {

                Caption = 'Retenues et Commissions';
                field("Compta. Retenue à la source"; rec."Compta. Retenue à la source")
                {
                    ApplicationArea = all;
                }
                field("Annuler Compta Retn. à la Sour"; rec."Annuler Compta Retn. à la Sour")
                {
                    ApplicationArea = all;
                }
                field("Retenue sur Garantie"; rec."Retenue sur Garantie")
                {
                    ApplicationArea = all;
                }
                field("Compta. Retenue Sur TVA"; rec."Compta. Retenue Sur TVA")
                {
                    ApplicationArea = all;
                }
                field("Compte Retenue Sur TVA"; rec."Compte Retenue Sur TVA")
                {
                    ApplicationArea = all;
                }
                field("Inclure Commission"; rec."Inclure Commission")
                {
                    ApplicationArea = all;
                }
                field("Compte Commission"; rec."Compte Commission")
                {
                    ApplicationArea = all;
                }
                field("Compte TVA/Commission"; rec."Compte TVA/Commission")
                {
                    ApplicationArea = all;
                }
                field("% TVA"; rec."% TVA")
                {
                    ApplicationArea = all;
                }
                field("Forcer Imputation débit/crédit"; rec."Forcer Imputation débit/crédit")
                {
                    ApplicationArea = all;
                }
                field("Inclure IntérêtFED"; rec."Inclure IntérêtFED")
                {
                    ApplicationArea = all;
                }
                field("Compte Intérêt FED"; rec."Compte Intérêt FED")
                {
                    ApplicationArea = all;
                }
                field("Inclure Intérêt Escompte"; rec."Inclure Intérêt Escompte")
                {
                    ApplicationArea = all;
                }
                field("Compte Intérêt Escompte"; rec."Compte Intérêt Escompte")
                {
                    ApplicationArea = all;
                }
                field("Inclure Interêt sur Prêt"; rec."Inclure Interêt sur Prêt")
                {
                    ApplicationArea = all;
                }
                field("Compte Intérêt sur Prêt"; rec."Compte Intérêt sur Prêt")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}

