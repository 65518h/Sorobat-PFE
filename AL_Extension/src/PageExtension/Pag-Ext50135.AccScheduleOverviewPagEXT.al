PageExtension 50135 "Acc. Schedule Overview_PagEXT" extends "Acc. Schedule Overview"
{

    layout
    {
        addafter(Description)
        {
            field(Note; Rec.Note)
            {
                ApplicationArea = all;
            }
        }
    }


    actions
    {
        addafter(Print)
        {
            action("Imprimer Note")
            {
                Caption = 'Print note';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    AccSchedName.SETFILTER(Name, rec."Schedule Name");
                    REPORT.RUN(50093, TRUE, FALSE, AccSchedName);
                end;
            }
            action("Note Comparée par AXE")
            {
                Caption = 'Note compared by AXIS';
                ApplicationArea = all;
                trigger OnAction()
                begin

                    //>> BSK 14 11 2011
                    AccSchedName.SETFILTER(Name, REC."Schedule Name");
                    REPORT.RUN(50297, TRUE, FALSE, AccSchedName);
                    //>> BSK 14 11 2011
                end;
            }

            /*GL2024  action("Exporter Fichier Liasse")
               {
                   Caption = 'Export bundle file';
                   ApplicationArea = all;
                   trigger OnAction()
                   begin


                       DataportLiasse.GetAnalyse(CurrentSchedName);
                       DataportLiasse.RUN;
                   end;
               }*/
        }
        addafter(Print_Promoted)
        {
            actionref("Imprimer Note1"; "Imprimer Note")
            {

            }
            actionref("Note Comparée par AXE1"; "Note Comparée par AXE")
            {

            }
        }
    }


    var
        ExportLiasse: Report "Export Acc. Sched. to Excel";

        //GL2024 DataportLiasse: xmlport "Liasse Actif";
        AccSchedName: Record "Acc. Schedule Name";

        a: Record "G/L Account";
}

