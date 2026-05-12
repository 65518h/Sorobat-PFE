page 52048909 "Recorded Worked hours"
{
    //GL2024  ID dans Nav 2009 : "39001430"
    Caption = 'Recorded Worked hours';
    Editable = false;
    PageType = List;
    SourceTable = "Heures sup. eregistrées m";
    ApplicationArea = all;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("N° Salarié"; rec."N° Salarié")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("N° Ligne"; rec."N° Ligne")
                {
                    ApplicationArea = all;
                }
                field("Nom usuel"; rec."Nom usuel")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("FORMAT (rec.Prénom) + ' ' + FORMAT(Taux de majoration)"; FORMAT(rec.Prénom) + ' ' + FORMAT(rec."Taux de majoration"))
                {
                    ApplicationArea = all;
                    Caption = 'Employee';
                }
                // field("Nombre Heures Supp"; rec."Nombre Heures Supp")
                // {
                //     ApplicationArea = all;
                // }
                field(Date; rec.Date)
                {
                    ApplicationArea = all;
                }
                field("Montant Ligne1"; rec."Montant Ligne")
                {
                    ApplicationArea = all;
                }
                // field("Nombre Heures Supp1"; rec."Nombre Heures Supp")
                // {
                //     ApplicationArea = all;
                // }
                field("Tarif unitaire"; rec."Tarif unitaire")
                {
                    ApplicationArea = all;
                }
                field("Montant Ligne2"; rec."Montant Ligne")
                {
                    ApplicationArea = all;
                }
                field("Employee Posting Group"; rec."Employee Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Nombre d'heures"; rec."Nombre d'heures")
                {
                    ApplicationArea = all;
                }
                field("Montant ligne"; rec."Montant ligne")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
        area(Promoted)
        {

            group("Recorded Worked &hours1")
            {
                Caption = 'Recorded Worked &hours';
                actionref("Co&mments1"; "Co&mments") { }
                actionref("Overview by &Periods1"; "Overview by &Periods") { }
            }
        }
        area(navigation)
        {
            group("Recorded Worked &hours")
            {
                Caption = 'Recorded Worked &hours';
                action("Co&mments")
                {
                    ApplicationArea = all;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    //  RunPageLink = "Table Name" = CONST(9), "No." = FIELD("N° Ligne"), "Table Line No." = FIELD("Nom usuel");
                }
                separator(separator100)
                {
                }
                action("Overview by &Periods")
                {
                    ApplicationArea = all;
                    Caption = 'Overview by &Periods';
                    RunObject = page "Supp.H Overview by Periods";
                }
            }
        }
    }
}

