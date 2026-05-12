Codeunit 8003907 "Import Item Category 5722"
{
    // //IMPORT_CUSTOM CW 21/07/03 Import customize

    TableNo = "Item Category";
    /* GL2024
        trigger OnRun()
        var
            lTree: Record 8003929;
        begin
            SingleInstance.Get(ImportLog);

            case SingleInstance.
              ImportLog.PreImportbegin
              end;

            ImportLog.BeforeUpdatebegin
                lTree.Type := lTree.Type::Item;
            lTree.Validate(Code, CopyStr(Code, 1, 3) + ' ' + DelChr(CopyStr(Code, 4))); // Validate -> Level
            lTree.Description := Description;
            if lTree.Insert then;
        end;

              ImportLog.PostImport;

            else
            end;
        end;
    */
    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
}

