page 50400 "ListeXmlport"
{
    // new page
    Caption = 'Liste Xmlport';
    ApplicationArea = all;
    UsageCategory = Lists;

    layout
    {

    }

    actions
    {
        area(processing)
        {
            action("Recuper Carriere V2")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Recuper Carriere V2';
                RunObject = xmlport "Recuper Carriere V2";


            }
            action("Disquette déclaration CNSS")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette déclaration CNSS';
                RunObject = xmlport "Disquette déclaration CNSS";


            }

            action("Disquette déclaration Exo CNSS")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette déclaration Exo CNSS';
                RunObject = xmlport "Disquette déclaration Exo CNSS";


            }

            action("Disquette déclaration Karama")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette déclaration Karama';
                RunObject = xmlport "Disquette déclaration Karama";


            }

            action("Disquette Virement Model")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement Model';
                RunObject = xmlport "Disquette Virement Model";


            }

            action("Disquette Virement BTE")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement BTE';
                RunObject = xmlport "Disquette Virement BTE";


            }

            action("Disquette Virement BNA")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement BNA';
                RunObject = xmlport "Disquette Virement BNA";


            }


            action("Disquette Virement BNA Enreg")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement BNA Enreg';
                RunObject = xmlport "Disquette Virement BNA Enreg";


            }


            action("Disquette Virement BTE 02")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement BTE 02';
                RunObject = xmlport "Disquette Virement BTE 02";


            }

            action("Disquette Virement STB")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'DDisquette Virement STB';
                RunObject = xmlport "Disquette Virement STB";

            }


            action("Disquette Virement TSB")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement TSB';
                RunObject = xmlport "Disquette Virement TSB";


            }

            action("Disquette Virement QNB")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Disquette Virement QNB';
                RunObject = xmlport "Disquette Virement QNB";

            }


            action("Etat Mensuel Paie")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Etat Mensuel Paie';
                RunObject = xmlport "Etat Mensuel Paie2";


            }
        }
    }


}

