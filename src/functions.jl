using JSON
using HTTP

function read_data(filename::String)
    f = open(f->read(f, String), filename)
    return f
end

function parse_json(data::String)
    return JSON.parse(data)
end

function write_data(filename::String, data)
    f = open(string(filename), "w")
    JSON.Writer.print(f, data, 2)
    close(f)
end

function ipynb_to_colab(notebook_name::String)
    # Reading normal ipynb notebook
    input_filename = notebook_name
    normal_data = read_data(input_filename)
    normal_json = parse_json(normal_data)

    # Reading the configuration notebook
    colab_json = parse_json(String(HTTP.get("https://raw.githubusercontent.com/Chandu-4444/Colab.jl/main/src/assets/Config_Notebook.json").body))
    # Updataing metadata
    normal_json["metadata"] = colab_json["metadata"]
    # Adding the configuration cell at the top
    pushfirst!(normal_json["cells"], colab_json["cells"][1])
    # output filename would be input_filename + "_colab.ipynb"
    output_filename = string(string(split(input_filename, ".")[1]), "_colab", ".ipynb")

    write_data(output_filename, normal_json)
end

export ipynb_to_colab
