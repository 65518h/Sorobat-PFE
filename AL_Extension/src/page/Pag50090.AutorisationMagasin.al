/*Page 50090 "Autorisation Magasin"
{
    PageType = list;
    SourceTable = "Autorisation Magasin";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Autorisation Magasin';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code Utilisateur"; rec."Code Utilisateur")
                {
                    ApplicationArea = all;
                }
                field("Code Magasin"; rec."Code Magasin")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}*/

