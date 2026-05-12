Page 50018 "Synchro Admin"
{
    Caption = 'Synchro Admin';
    ApplicationArea = all;
    PageType = card;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
        }
    }

    actions
    {
        area(Promoted)
        {
            actionref("RECUP IMAGE CHANTIER1"; "RECUP IMAGE CHANTIER")
            {

            }
            group("ENVOI - RECUP IMAGE BASE1")
            {
                Caption = 'SEND - BASE IMAGE RECOVERY';
                group("PARTIE ADMINISTRATION1")
                {
                    Caption = 'ADMINISTRATION SECTION';

                    actionref("ENVOI  IMAGE1"; "ENVOI  IMAGE")
                    {
                        Visible = false;
                    }

                    //  actionref("RECUP IMAGE CHANTIER1"; "RECUP IMAGE CHANTIER")
                    //                     {

                    //                     }
                }
                group(IMAGE1)
                {
                    Caption = 'IMAGE';
                    Visible = false;

                    actionref("HIST IMAGE ADMIN1"; "HIST IMAGE ADMIN")
                    {

                    }
                    actionref("HIST IMAGE CHANTIER1"; "HIST IMAGE CHANTIER")
                    {

                    }
                    actionref("PARAMETRAGE IMAGE1"; "PARAMETRAGE IMAGE")
                    {

                    }


                }


            }

        }
        area(creation)
        {
            group("ENVOI - RECUP IMAGE BASE")
            {
                Caption = 'SEND - BASE IMAGE RECOVERY';

                group("PARTIE ADMINISTRATION")
                {
                    Caption = 'ADMINISTRATION SECTION';
                    action("ENVOI  IMAGE")
                    {
                        ApplicationArea = all;
                        Caption = 'SEND IMAGE';
                        Visible = false;

                        trigger OnAction()
                        begin
                            XMLPORT.Run(50006, false);
                        end;
                    }
                    action("RECUP IMAGE CHANTIER")
                    {
                        ApplicationArea = all;
                        Caption = 'RECUP IMAGE CHANTIER';
                        Image = Import;
                        RunObject = XmlPort "RecupImageChantier";

                        // trigger OnAction()
                        // begin
                        //     ParametrageImage.SetRange(Chantier, true);
                        //     if ParametrageImage.FindFirst then
                        //         repeat
                        //             if CONFIRM(Text001, FALSE, 'IMAGE-' + ParametrageImage."Dernier Document") then begin
                        //                 DataportImage.GetNomFichier('IMAGE-' + ParametrageImage."Dernier Document");
                        //                 DataportImage.Run;
                        //             end;
                        //         until ParametrageImage.Next = 0;
                        // end;
                    }
                }
                group(IMAGE)
                {
                    Caption = 'IMAGE';
                    action("HIST IMAGE ADMIN")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Caption = 'HIST IMAGE ADMIN';

                        trigger OnAction()
                        begin
                            Page.Run(Page::"Image Admin");
                        end;
                    }
                    action("HIST IMAGE CHANTIER")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Caption = 'HISTORY IMAGE CONSTRUCTION SITE';

                        trigger OnAction()
                        begin
                            Page.Run(Page::"Image Chantier");
                        end;
                    }
                    action("RECUP IMAGE CARRIERE")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Caption = 'RECUP IMAGE CARRIERE';

                        trigger OnAction()
                        begin
                            ParametrageImage.SETRANGE(Chantier, TRUE);
                            IF ParametrageImage.FINDFIRST THEN
                                REPEAT
                                    DataportImage.GetNomFichier('IMAGE-' + ParametrageImage."Dernier Document");
                                //   DataportCarriere.RUN;
                                UNTIL ParametrageImage.NEXT = 0;
                        end;
                    }
                    action("RECUP DA")
                    {
                        ApplicationArea = all;
                        Caption = 'RECUP DA';
                        Visible = false;

                        trigger OnAction()
                        begin
                            Xmlport.RUN(50023, FALSE);

                        end;
                    }
                    action("PARAMETRAGE IMAGE")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Caption = 'IMAGE SETTINGS';

                        trigger OnAction()
                        begin
                            Page.Run(Page::"Parametrage Image");
                        end;
                    }

                }
            }
        }
    }

    var
        ParametrageImage: Record "Parametrage Image";
        DataportImage: XmlPort RecupImageChantier;
        Text001: label 'Start the recovery of Project %1';
    //  DataportCarriere: XmlPort 50011;

}

