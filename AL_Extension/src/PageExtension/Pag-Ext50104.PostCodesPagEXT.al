
PageExtension 50104 "Post Codes_PagEXT" extends "Post Codes"
{

    layout
    {
        addafter(City)
        {
            field(Longitude; Rec.Longitude)
            {
                ApplicationArea = all;
            }
            field(Latitude; Rec.Latitude)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast(Creation)
        {
            //  group("Fonction&s")
            // {
            // Caption = 'F&unctions';
            /* GL2024    action("Import communes")
               {
                   ApplicationArea = all;
                   Caption = 'PostCode Import';

                   trigger OnAction()
                   begin*/

            /* GL2024 IF (NOT ISSERVICETIER) THEN BEGIN
                  DATAPORT.RUN(DATAPORT::"Import Post Code Lambert.", TRUE, Rec);
              END ELSE BEGIN*/
            //DYS XMLPORT addon non migrer
            //  XMLPORT.RUN(XMLPORT::"Import Post Code Lambert.", TRUE, TRUE, Rec);
            // END;

            //     end;
            // }
            /* GL2024    action("Distance")
               {
                   ApplicationArea = all;
                   Caption = 'Distance';

                   trigger OnAction()
                   var
                       //DYS page addon non migrer
                       //  lDist: Page 8003942;
                       lInfoSoc: Record "Company Information";
                   begin

                       lInfoSoc.GET;
                       // lDist.InitPostCode(REC.Code, REC.City, lInfoSoc."Post Code", lInfoSoc.City);
                       //lDist.RUNMODAL;
                   end;
               }*/
            /* GL2024   group("Déplacements")
              {
                  Caption = 'Movements';
                  action(Depuis)
                  {
                      ApplicationArea = all;
                      Caption = 'Since';
                      //DYS page addon non migrer
                      // RunObject = Page 8004023;
                      // RunPageLink = "Resource Travel Code" = FIELD(Code);
                  }
                  action(Vers)
                  {
                      ApplicationArea = all;
                      Caption = 'To';
                      //DYS page addon non migrer
                      // RunObject = Page 8004023;
                      // RunPageLink = "Job Travel Code" = FIELD(Code);
                  }
              }*/
            // }
        }
    }


}