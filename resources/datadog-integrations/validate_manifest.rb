def validate_manifest(manifest_hash)
  puts manifest_hash
  raise "manifest.json needs a manifest_version field" unless manifest_hash.key?("manifest_version")
  validate_manifest_version = manifest_hash["manifest_version"].gsub! '.', '_'
  send("validate_manifest_#{validate_manifest_version}", manifest_hash)
  puts "manifest is valid"
end

def validate_manifest_0_1_1(manifest_hash)
  mandatory_fields = [
    "type",
  ]
  validate_manifest_0_1_0(manifest_hash, extra_fields=mandatory_fields)
end

def validate_manifest_0_1_0(manifest_hash, extra_fields=nil)
  mandatory_fields = [
    "maintainer",
    "manifest_version",
    "max_agent_version",
    "min_agent_version",
    "name",
    "short_description",
    "support",
    "version",
    "guid",
  ]
  if extra_fields != nil
    mandatory_fields += extra_fields
  end
  validate_manifest_loop(manifest_hash, mandatory_fields)
end

def validate_manifest_1_0_0(manifest_hash)
  mandatory_fields = [
    "maintainer",
    "manifest_version",
    "max_agent_version",
    "min_agent_version",
    "name",
    "short_description",
    "support",
    "version",
    "guid",
  ]
  validate_manifest_loop(manifest_hash, mandatory_fields)
end

def validate_manifest_loop(manifest_hash, mandatory_fields)
  mandatory_fields.each do |field|
    raise "manifest.json needs proper fields, currently missing #{field}. Please refer to documentation" unless manifest_hash.key?(field)
  end
end
