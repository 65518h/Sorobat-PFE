Page 52049017 "Formule Beton"
{//GL2024  ID dans Nav 2009 : "39004811"
    PageType = List;
    SourceTable = "Formule Beton";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Formule Beton';

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Code Formule"; REC."Code Formule")
                {

                    ApplicationArea = Basic;
                }
                field(Ciment; REC.Ciment)
                {

                    ApplicationArea = Basic;
                }
                field(Formule; REC.Formule)
                {
                    ApplicationArea = Basic;
                }
                field("Gravier 6/14"; REC."Gravier 6/14")
                {
                    ApplicationArea = Basic;
                }
                field("Gravier 12/20"; REC."Gravier 12/20")
                {
                    ApplicationArea = Basic;
                }
                field("gravier 25/40"; REC."gravier 25/40")
                {
                    ApplicationArea = Basic;
                }
                field(Sable; REC.Sable)
                {
                    ApplicationArea = Basic;
                }
                field(Commentaire; REC.Commentaire)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(ActionGroup1000000020)
            {
                Visible = true;
                action(Modifier)
                {
                    ApplicationArea = Basic;
                    Caption = 'Modifier';
                    ShortCutKey = 'Ctrl+M';

                    trigger OnAction()
                    begin
                        CurrPage.Editable(true);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CurrPage.Editable(not CurrPage.LookupMode);
    end;
}

