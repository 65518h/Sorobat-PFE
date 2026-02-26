Page 59999 MSPROJECT
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'MSPROJECT';

    layout
    {
    }

    actions
    {
        area(processing)
        {
            action(ECRIRE)
            {
                ApplicationArea = all;
                Caption = 'ECRIRE';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    //GL2024 Automation
                    /*IF NOT CREATE(MSPROJECT,TRUE,TRUE) THEN ;
                    
                    MSPROJECT.FileNew;
                    MSPROJECT.SetTaskField('Name','one all');
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 1');
                    MSPROJECT.SelectTaskField(1,'Resource Names');
                    MSPROJECT.SetTaskField('Resource Names', 'RES 01[100%]',TRUE);
                    MSPROJECT.OutlineIndent(2);
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 2');
                    MSPROJECT.SetTaskField('Resource Names', 'RES 02[100%]',TRUE);
                    MSPROJECT.OutlineIndent(2);
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 3');
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 4');
                    MSPROJECT.OutlineOutdent;
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 5');
                    
                    //MSPROJECT.OutlineOutdent;
                    //MSPROJECT.SetTaskField('Resource Names', 'RES 01[100%]',TRUE);
                    MSPROJECT.FileSaveAs('c:\Myt.mpp');
                    
                    CLEAR(MSPROJECT);    */

                end;
            }
            action(LIRE)
            {
                ApplicationArea = all;
                Caption = 'LIRE';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin

                    //GL2024 Automation
                    //IF NOT CREATE(MSPROJECT,TRUE,TRUE) THEN ;
                    //GL2024 Automation FIN
                    /*
                    MSPROJECT.FileNew;
                    MSPROJECT.SetTaskField('Name','one all');
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 1');
                    MSPROJECT.SelectTaskField(0, 'Duration');
                    MSPROJECT.SelectTaskField(2,'Name');
                    MSPROJECT.SetTaskField('Name', 'task 2');
                    MSPROJECT.SelectTaskField(0, 'Duration');
                    MSPROJECT.SelectTaskField(0,'Name');
                    
                    MSPROJECT.OutlineIndent;
                    MSPROJECT.SelectTaskField(1,'Name');
                    MSPROJECT.SelectTaskField(-1,'Name');
                    MSPROJECT.SetTaskField('Resource Names', 'RES 01[100%]',TRUE);
                    MSPROJECT.FileSaveAs('c:\Myt.mpp');
                    
                    
                    */
                    //GL2024 Automation
                    /*MSPROJECT.FileOpenEx('c:\GK.mpp');
                    //MSPROJECT.ActiveProject.Activate;
                    MSPROJECT.SelectCell(8,6,FALSE);
                    //message(MSPROJECT.ActiveCell.FieldName);
                    //MESSAGE ( MSPROJECT.ActiveCell.Text);
                    
                    MSPROJECT.SelectCell(4, 4,FALSE);
                    
                    MESSAGE ( MSPROJECT.ActiveCell.Text);
                    
                    MSPROJECT.SelectCell(4, 5,FALSE);
                    
                    MESSAGE ( MSPROJECT.ActiveCell.Text);
                    
                    CLEAR(MSPROJECT);*/
                    //GL2024 Automation FIN

                end;
            }
        }
    }
}

