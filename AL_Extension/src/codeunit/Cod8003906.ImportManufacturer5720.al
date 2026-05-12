Codeunit 8003906 "Import Manufacturer 5720"
{
    // //IMPORT_CUSTOM CW 21/07/03 Import customize

    TableNo = Manufacturer;
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
            lTree.Code := Code;
            lTree.Description := Name;
            if lTree.Insert then;
        end;

              ImportLog.BeforeUpdate;

              ImportLog.PostImport;

            else
            end;
        end;
    */
    var
        ImportLog: Record "Import Log";
        SingleInstance: Codeunit "Import SingleInstance2";
}

