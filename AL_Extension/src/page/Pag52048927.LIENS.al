Page 52048927 LIENS
{//GL2024  ID dans Nav 2009 : "39002128"
    PageType = Card;
    //GL3900   SourceTable = Liens;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(type; type)
            {
                ApplicationArea = Basic;
                Caption = 'Tree view';

                trigger OnValidate()
                begin
                    if type = Type::Equipements then begin
                        equipVisible := true;
                        siteVisible := false;
                        familleVisible := false;

                    end else
                        if type = Type::Site then begin
                            equipVisible := false;
                            siteVisible := true;
                            familleVisible := false;

                        end else
                            if type = Type::Famille then begin
                                equipVisible := false;
                                siteVisible := false;
                                familleVisible := true;

                            end;
                end;
            }
            //GL3900 
            /* part(site; "Lien site")
             {
                 Visible = siteVisible;
             }*/
            //GL3900 
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        familleVisible := true;
        siteVisible := true;
        equipVisible := true;
    end;

    trigger OnOpenPage()
    begin
        equipVisible := true;
        siteVisible := false;
        familleVisible := false;
    end;

    var
        type: Option Equipements,Famille,Site;
        [InDataSet]
        equipVisible: Boolean;
        [InDataSet]
        siteVisible: Boolean;
        [InDataSet]
        familleVisible: Boolean;
}

