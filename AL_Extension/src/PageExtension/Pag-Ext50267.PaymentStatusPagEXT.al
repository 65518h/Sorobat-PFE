PageExtension 50267 "Payment Status_PagEXT" extends "Payment Status"
{

    //GL2024 AutoSplitKey=false;
    layout
    {
        addfirst(Control1)
        {
            field("Payment Class"; rec."Payment Class")
            {
                ApplicationArea = All;
            }
            field(Line; rec.Line)
            {
                ApplicationArea = All;
            }
        }
        addafter(Name)
        {
            field(Rapprocher; rec.Rapprocher)
            {
                ApplicationArea = All;
            }
            field("Compte Rapprochement"; rec."Compte Rapprochement")
            {
                ApplicationArea = All;
            }
            field("Retenu Loyer"; rec."Retenu Loyer")
            {
                ApplicationArea = All;
            }
            field("Type Engagement"; rec."Type Engagement")
            {
                ApplicationArea = All;
            }
            field("Sens Engagement"; rec."Sens Engagement")
            {
                ApplicationArea = All;
            }
            field("Changement Agence Permis"; rec."Changement Agence Permis")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Changement Agence Par"; rec."Changement Agence Par")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter(ReportMenu)
        {
            field("Acceptation Code"; rec."Acceptation Code")
            {
                ApplicationArea = All;
            }
        }

        addafter("Archiving Authorized")
        {
            field("Communication XRT"; rec."Communication XRT")
            {
                ApplicationArea = All;
            }
            field("En Banque"; rec."En Banque")
            {
                ApplicationArea = All;
            }
            field(Annulation; rec.Annulation)
            {
                ApplicationArea = All;
            }
            field("Calculer Retenue à la source"; rec."Calculer Retenue à la source")
            {
                ApplicationArea = All;
            }
            field("Calculer Retenue Sur TVA"; rec."Calculer Retenue Sur TVA")
            {
                ApplicationArea = All;
            }
            field("Tva Sur Commission"; rec."Tva Sur Commission")
            {
                ApplicationArea = All;
            }
            field(Commission; rec.Commission)
            {
                ApplicationArea = All;
            }
            field("Référence Chèque"; rec."Référence Chèque")
            {
                ApplicationArea = All;
            }
            field(Modifiable; rec.Modifiable)
            {
                ApplicationArea = All;
            }
        }
    }
}

