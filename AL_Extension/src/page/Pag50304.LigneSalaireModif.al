Page 50304 "Ligne Salaire Modif"
{
    PageType = List;
    SourceTable = "Salary Lines";
    //ABZ ApplicationArea = all;
    Caption = 'Ligne Salaire Modif';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; REC."No.")
                {
                    ApplicationArea = all;
                }
                field(Employee; REC.Employee)
                {
                    ApplicationArea = all;
                }
                field(Name; REC.Name)
                {
                    ApplicationArea = all;
                }
                field("Gross Salary"; REC."Gross Salary")
                {
                    ApplicationArea = all;
                }
                field(CNSS; REC.CNSS)
                {
                    ApplicationArea = all;
                }
                field("Taxable salary"; REC."Taxable salary")
                {
                    ApplicationArea = all;
                }
                field("Taxe (Month)"; REC."Taxe (Month)")
                {
                    ApplicationArea = all;
                }
                // field("Contribution Social"; REC."Contribution Social")
                // {
                //     ApplicationArea = all;
                // }
                field("Net salary"; REC."Net salary")
                {
                    ApplicationArea = all;
                }
                field("Net salary cashed"; REC."Net salary cashed")
                {
                    ApplicationArea = all;
                }
                field("Ajout  en +"; REC."Ajout  en +")
                {
                    ApplicationArea = all;
                }
                field("Report en -"; REC."Report en -")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

