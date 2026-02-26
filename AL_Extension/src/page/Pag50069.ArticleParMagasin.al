Page 50069 "Article Par Magasin"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "Article Par Magasin";
    Caption = 'Article Par Magasin';
    ApplicationArea = All;
    PopulateAllFields = true;
    layout
    {
        area(content)
        {

            repeater(Control1)
            {
                ShowCaption = false;
                field(Magasin; rec.Magasin)
                {
                    ApplicationArea = all;
                }
                field("Quantité"; rec.Quantité)
                {
                    ApplicationArea = all;
                    DecimalPlaces = 0 : 3;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculer Stock Article par Magasin")
            {
                ApplicationArea = all;
                Caption = 'Calculer Stock Article par Magasin';
                Image = Inventory;

                trigger OnAction()
                VAR

                BEGIN
                    CalculArticleParMagasin(rec.Article);
                    CurrPage.UPDATE;
                END;

            }
        }
    }
    procedure CalculArticleParMagasin(CodLArticle: code[20])
    VAR
        LUserSetup: Record "User Setup";
        ArticleParMagasin: Record "Article Par Magasin";
        magasin: Record Location;
        RecItem: Record Item;
    BEGIN
        ArticleParMagasin.RESET;
        Magasin.RESET;
        ArticleParMagasin.SETRANGE(Article, CodLArticle);
        ArticleParMagasin.DELETEALL;
        // >> HJ SORO 26-02-2015
        IF LUserSetup.GET(UPPERCASE(USERID)) THEN
            // IF LUserSetup."Filtre Magasin" <> '' THEN Magasin.SETRANGE(Code, LUserSetup."Filtre Magasin");
            // >> HJ SORO 29-02-2015

            IF Magasin.FINDFIRST THEN
                REPEAT
                    RecItem.SETRANGE("No.", CodLArticle);
                    RecItem.SETFILTER("Location Filter", Magasin.Code);
                    IF RecItem.FINDFIRST THEN BEGIN
                        RecItem.CALCFIELDS(Inventory);

                        IF RecItem.Inventory <> 0 THEN BEGIN
                            ArticleParMagasin.RESET;
                            ArticleParMagasin.Article := CodLArticle;
                            ArticleParMagasin.Magasin := Magasin.Code;
                            ArticleParMagasin.Quantité := RecItem.Inventory;
                            ArticleParMagasin.INSERT;
                        END;
                    END;
                UNTIL Magasin.NEXT = 0;
    END;
}

