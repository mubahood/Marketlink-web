<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Schema;

class Gen extends Model
{
    use HasFactory;

    //generate model
    public function gen_model()
    {
        $table_cols = Schema::getColumnListing($this->table_name);
        $variables = $this->makeVars($table_cols);
        $fromJson = Gen::fromJsons($table_cols);
        $toJson = Gen::to_json($table_cols);
        $sqlTableVars = Gen::sqlTableVars($table_cols);


        $this->end_point = $this->endpoint;
        $x = <<<EOT
        <pre>import 'package:flutter/material.dart';
        import 'package:flutter_ui/model/ResponseModel.dart';
        import 'package:flutter_ui/model/Utils.dart';
        import 'package:sqflite/sqflite.dart';
        

            class $this->class_name {
                static String end_point = "{$this->endpoint}";
                static String tableName = "{$this->table_name}";

                $variables

        
                static Future&ltList&lt{$this->class_name}&gt&gt get_items(
                    {String where = ""}) async {
                        List&lt{$this->class_name}&gt items = await get_local_items();
                        if (items.isEmpty) {
                            await get_online_items();
                            items = await get_local_items();
                        } else {
                            get_online_items();
                        }
                    return items;
                }


        static Future&ltList&lt{$this->class_name}&gt&gt get_local_items({
            String where = " 1 ",
            }) async {
            List&lt{$this->class_name}&gt data = [];
            Database db = await Utils.getDb();
            if (!db.isOpen) {
                Utils.toast('Failed to open database.', c: Colors.red);
                return data;
            }
        
            String table_resp = await initTable(db);
            if (!table_resp.isEmpty) {
                Utils.toast('Failed to init table {$this->table_name}. \$table_resp',
                    c: Colors.red);
                return data;
            }
        
            List&ltMap&gt maps =
                await db.query(tableName, where: where, orderBy: ' id DESC ');
        
            if (maps.isEmpty) {
                return data;
            }
            List.generate(maps.length, (i) {
                data.add({$this->class_name}.fromJson(maps[i]));
            });
            return data;
            } 


            static fromJson(dynamic m) {
                $this->class_name item =  $this->class_name();
                    if (m == null) {
                        return item;
                    }
                $fromJson
                return item;
            }


             

            static Future&ltvoid&gt get_online_items() async {
                if (!(await Utils.isConnected())) {
                  return;
                }
                ResponseModel? resp = null;
                try {
                  resp = ResponseModel(await Utils.http_get('api/\$end_point', {}));
                } catch (e) {
                  resp = null;
                }
                if (resp == null) {
                  print("FAILED TO FETCH DATA");
                  return;
                }
            
                if (resp.code != 1) {
                  Utils.toast(
                    "Failed to fetch \$tableName data. \${resp . message}",
                    c: Colors.red,
                  );
                  return;
                }
            
                try {
                  await delete_all();
                } catch (e) {
                  Utils.toast("Failed to delete all \$tableName data. \${e . toString()}",
                      c: Colors.red);
                }
            
                if (!(resp.data.runtimeType.toString().toLowerCase().contains('list'))) {
                  Utils.toast("Failed to fetch \$tableName data. \${resp . data}",
                      c: Colors.red);
                  return;
                }
            
                //database db
                Database db = await Utils.getDb();
                //init table
                String tamp_resp = await initTable(db);
            
                if (!tamp_resp.isEmpty) {
                  Utils.toast("Failed to init table \$tableName. \$tamp_resp", c: Colors.red);
                  return;
                }
                await db.transaction((transaction) async {
                  var batch = transaction.batch();
                  for (var x in resp?.data) {
                    {$this->class_name} item = {$this->class_name}.fromJson(x);
                    try {
                      batch.insert(tableName, item.toJson(),
                          conflictAlgorithm: ConflictAlgorithm.replace);
                    } catch (e) {
                      Utils.toast("Failed to save \$tableName data. \${e . toString()}",
                          c: Colors.red);
                    }
                  }
                  try {
                    await batch.commit(continueOnError: true);
                  } catch (e) {
                    Utils.toast("Failed to commit \$tableName data. \${e . toString()}",
                        c: Colors.red);
                  }
                });
              }





              static Future&ltString&gt delete_all() async {
                Database db = await Utils.getDb();
                if (!db.isOpen) {
                  return 'Failed to open database.';
                }
                try {
                  await db.delete(tableName);
                  return '';
                } catch (e) {
                  return 'Failed to delete table because \${e.toString()}.';
                }
              }


              Future&ltString&gt delete() async {
                Database db = await Utils.getDb();
                if (!db.isOpen) {
                  return 'Failed to open database.';
                }
                try {
                  await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
                  return '';
                } catch (e) {
                  return 'Failed to delete item because \${e.toString()}.';
                }
              }


              static Future&ltString&gt delete_item(int id) async {
                Database db = await Utils.getDb();
                if (!db.isOpen) {
                  return 'Failed to open database.';
                }
                try {
                  await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
                  return '';
                } catch (e) {
                  return 'Failed to delete item because \${e.toString()}.';
                }
              }


              Future&ltString&gt save() async {
                Database db = await Utils.getDb();
                String table_results = await initTable(db);
                if (table_results.isNotEmpty) {
                  return table_results;
                }
                try {
                  await db.insert(tableName, toJson(),
                      conflictAlgorithm: ConflictAlgorithm.replace);
                  return "";
                } catch (e) {
                  return 'Failed to save item because \${e.toString()}.';
                }
                return "";
              }



              static Future&ltString&gt initTable(Database db) async {
                if (!db.isOpen) {
                  Utils.toast('Failed to open database.', c: Colors.red);
                  return 'Failed to open database.';
                }
                String sql = 'CREATE TABLE IF NOT EXISTS \${tableName} ('
                     {$sqlTableVars}
                    ')';
                try {
                  await db.execute(sql);
                  return "";
                } catch (e) {
                  return 'Failed to create table because \${e . toString()}.';
                }
              } 

              
              toJson() {
                return {
                    $toJson
                };
              }
            

        }
        </pre>
        EOT;

        echo $x;
        die();
    }


    public  function sqlTableVars($tables)
    {


        $_data = "";
        $done = [];
        foreach ($tables as $v) {
            $key = trim($v);
            if (strlen($key) < 1) {
                continue;
            }
            if (in_array($key, $done)) {
                continue;
            }
            $done[] = $key;
            if ($key == 'id') {
                $_data .= "\"{$key} INTEGER PRIMARY KEY\"<br>";
            } else {
                $_data .= "\",{$key} TEXT\"<br>";
                if (str_contains($key, '_id')) {
                    $_key = str_replace('_id', '_text', $key);
                    $_data .= "\",{$_key} TEXT\"<br>";
                }
            }
        }

        return $_data;
    }




    public static function to_json($recs)
    {
        $_data = "";
        foreach ($recs as $v) {
            $key = trim($v);
            if (strlen($key) < 2) {
                continue;
            }
            $_data .= "'$key' : $key,<br>";
            if (str_contains($key, '_id')) {
                $_key = str_replace('_id', '_text', $key);
                $_data .= "'$_key' : $_key,<br>";
            }
        }
        return $_data;
    }

    public static function fromJsons($recs = [])
    {
        $_data = "";
        foreach ($recs as $v) {
            $key = trim($v);
            if (strlen($key) < 1) {
                continue;
            }
            if ($key == 'id') {
                $_data .= "item.{$key} = Utils.int_parse(m['{$key}']);<br>";
            } else {
                $_data .= "item.{$key} = Utils.to_str(m['{$key}']);<br>";
                if (str_contains($key, '_id')) {
                    $_key = str_replace('_id', '_text', $key);
                    $_data .= "item.{$_key} = Utils.to_str(m['{$_key}']);<br>";
                }
            }
        }
        return $_data;
    }


    public  function makeVars($table_cols)
    {
        $_data = "";
        $i = 0;
        $done = [];

        foreach ($table_cols as $v) {
            $key = trim($v);
            if (strlen($key) < 1) {
                continue;
            }
            if (in_array($key, $done)) {
                continue;
            }
            if ($key == 'id') {
                $_data .= "int {$key} = 0;<br>";
            } else {
                $_data .= "String {$key} = \"\";<br>";
                if (str_contains($key, '_id')) {
                    $_key = str_replace('_id', '_text', $key);
                    $_data .= "String {$_key} = \"\";<br>";
                }
            }
        }
        return $_data;
    }
}
