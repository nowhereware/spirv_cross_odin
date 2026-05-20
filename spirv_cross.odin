package spirv_cross_odin

when ODIN_OS == .Windows {
	LIB_PATH :: "spirv-cross-c.lib"
}

@(export)
foreign import lib {LIB_PATH}

Context :: rawptr
Parsed_IR :: rawptr
Compiler :: rawptr
Compiler_Options :: rawptr
Resources :: rawptr
Type :: rawptr
Constant :: rawptr
Set :: rawptr

Type_ID :: u32
Variable_ID :: u32
Constant_ID :: u32

Reflected_Resource :: struct {
	id:           Variable_ID,
	base_type_id: Type_ID,
	type_id:      Type_ID,
	name:         cstring,
}

Reflected_Builtin_Resource :: struct {
	builtin:       Built_In,
	value_type_id: Type_ID,
	resource:      Reflected_Resource,
}

Entry_Point :: struct {
	execution_model: Execution_Model,
	name:            cstring,
}

Combined_Image_Sampler :: struct {
	combined_id: Variable_ID,
	image_id:    Variable_ID,
	sampler_id:  Variable_ID,
}

Specialization_Constant :: struct {
	id:          Constant_ID,
	constant_id: u32,
}

Buffer_Range :: struct {
	index:  u32,
	offset: uint,
	range:  uint,
}

HLSL_Root_Constants :: struct {
	start:   u32,
	end:     u32,
	binding: u32,
	space:   u32,
}

HLSL_Vertex_Attribute_Remap :: struct {
	location: u32,
	semantic: cstring,
}

Result :: enum i32 {
	SUCCESS                 = 0,
	ERROR_INVALID_SPIRV     = -1,
	ERROR_UNSUPPORTED_SPIRV = -2,
	ERROR_OUT_OF_MEMORY     = -3,
	ERROR_INVALID_ARGUMENT  = -4,
}

Capture_Mode :: enum i32 {
	COPY           = 0,
	TAKE_OWNERSHIP = 1,
}

Backend :: enum i32 {
	NONE = 0,
	GLSL = 1,
	HLSL = 2,
	MSL  = 3,
	CPP  = 4,
	JSON = 5,
}

Resource_Type :: enum i32 {
	UNKNOWN                = 0,
	UNIFORM_BUFFER         = 1,
	STORAGE_BUFFER         = 2,
	STAGE_INPUT            = 3,
	STAGE_OUTPUT           = 4,
	SUBPASS_INPUT          = 5,
	STORAGE_IMAGE          = 6,
	SAMPLED_IMAGE          = 7,
	ATOMIC_COUNTER         = 8,
	PUSH_CONSTANT          = 9,
	SEPARATE_IMAGE         = 10,
	SEPARATE_SAMPLERS      = 11,
	ACCELERATION_STRUCTURE = 12,
	RAY_QUERY              = 13,
	SHADER_RECORD_BUFFER   = 14,
	GL_PLAIN_UNIFORM       = 15,
	TENSOR                 = 16,
}

Builtin_Resource_Type :: enum i32 {
	UNKNOWN      = 0,
	STAGE_INPUT  = 1,
	STAGE_OUTPUT = 2,
}

Base_Type :: enum i32 {
	UNKNOWN                = 0,
	VOID                   = 1,
	BOOLEAN                = 2,
	INT8                   = 3,
	UINT8                  = 4,
	INT16                  = 5,
	UINT16                 = 6,
	INT32                  = 7,
	UINT32                 = 8,
	INT64                  = 9,
	UINT64                 = 10,
	ATOMIC_COUNTER         = 11,
	FP16                   = 12,
	FP32                   = 13,
	FP64                   = 14,
	STRUCT                 = 15,
	IMAGE                  = 16,
	SAMPLED_IMAGE          = 17,
	SAMPLER                = 18,
	ACCELERATION_STRUCTURE = 19,
}

COMPILER_OPTION_COMMON :: 0x1000000
COMPILER_OPTION_GLSL :: 0x20000000
COMPILER_OPTION_HLSL :: 0x40000000
COMPILER_OPTION_MSL :: 0x80000000
COMPILER_OPTION_LANG :: 0x0f000000

MAKE_MSL_VERSION :: proc(#any_int major: int, #any_int minor: int, #any_int patch: int) -> int {
	return (major * 10000) + (minor * 100) + patch
}

MSL_Platform :: enum i32 {
	IOS   = 0,
	MACOS = 1,
}

MSL_Index_Type :: enum i32 {
	NONE   = 0,
	UINT16 = 1,
	UINT32 = 2,
}

MSL_Shader_Variable_Format :: enum i32 {
	OTHER  = 0,
	UINT8  = 1,
	UINT16 = 2,
	ANY16  = 3,
	ANY32  = 4,
}

MSL_Vertex_Attribute :: struct {
	location:     u32,
	msl_buffer:   u32,
	msl_offset:   u32,
	msl_stride:   u32,
	per_instance: b8,
	format:       MSL_Shader_Variable_Format,
	builtin:      Built_In,
}

// DEPRECATED, use MSL_Shader_Interface_Var_2
MSL_Shader_Interface_Var :: struct {
	location: u32,
	format:   MSL_Shader_Variable_Format,
	builtin:  Built_In,
	vecsize:  u32,
}

MSL_Shader_Variable_Rate :: enum i32 {
	PER_VERTEX    = 0,
	PER_PRIMITIVE = 1,
	PER_PATCH     = 2,
}

MSL_Shader_Interface_Var_2 :: struct {
	location: u32,
	format:   MSL_Shader_Variable_Format,
	builtin:  Built_In,
	vecsize:  u32,
	rate:     MSL_Shader_Variable_Rate,
}

// DEPRECATED, use MSL_Resource_Binding_2
MSL_Resource_Binding :: struct {
	stage:       Execution_Model,
	desc_set:    u32,
	binding:     u32,
	msl_buffer:  u32,
	msl_texture: u32,
	msl_sampler: u32,
}

MSL_Resource_Binding_2 :: struct {
	stage:       Execution_Model,
	desc_set:    u32,
	binding:     u32,
	count:       u32,
	msl_buffer:  u32,
	msl_texture: u32,
	msl_sampler: u32,
}

MSL_PUSH_CONSTANT_DESC_SET :: (~u32(0))
MSL_PUSH_CONSTANT_BINDING :: 0
MSL_SWIZZLE_BUFFER_BINDING :: (~u32(1))
MSL_BUFFER_SIZE_BUFFER_BINDING :: (~u32(2))
MSL_ARGUMENT_BUFFER_BINDING :: (~u32(3))

MSL_Sampler_Coord :: enum i32 {
	NORMALIZED = 0,
	PIXEL      = 1,
}

MSL_Sampler_Filter :: enum i32 {
	NEAREST = 0,
	LINEAR  = 1,
}

MSL_Sampler_Mip_Filter :: enum i32 {
	NONE    = 0,
	NEAREST = 1,
	LINEAR  = 2,
}

MSL_Sampler_Address :: enum i32 {
	CLAMP_TO_ZERO   = 0,
	CLAMP_TO_EDGE   = 1,
	CLAMP_TO_BORDER = 2,
	REPEAT          = 3,
	MIRRORED_REPEAT = 4,
}

MSL_Sampler_Compare_Func :: enum i32 {
	NEVER         = 0,
	LESS          = 1,
	LESS_EQUAL    = 2,
	GREATER       = 3,
	GREATER_EQUAL = 4,
	EQUAL         = 5,
	NOT_EQUAL     = 6,
	ALWAYS        = 7,
}

MSL_Sampler_Border_Color :: enum i32 {
	TRANSPARENT_BLACK = 0,
	OPAQUE_BLACK      = 1,
	OPAQUE_WHITE      = 2,
}

MSL_Format_Resolution :: enum i32 {
	_444 = 0,
	_422,
	_420,
}

MSL_Chroma_Location :: enum i32 {
	COSITED_EVEN = 0,
	MIDPOINT,
}

MSL_Component_Swizzle :: enum i32 {
	IDENTITY = 0,
	ZERO,
	ONE,
	R,
	G,
	B,
	A,
}

MSL_Sampler_YCBCR_Model_Conversion :: enum i32 {
	RGB_IDENTITY = 0,
	YCBCR_IDENTITY,
	YCBCR_BT_709,
	YCBCR_BT_601,
	YCBCR_BT_2020,
}

MSL_Sampler_YCBCR_Range :: enum i32 {
	ITU_FULL = 0,
	ITU_NARROW,
}

MSL_Constexpr_Sampler :: struct {
	coord:             MSL_Sampler_Coord,
	min_filter:        MSL_Sampler_Filter,
	mag_filter:        MSL_Sampler_Filter,
	mip_filter:        MSL_Sampler_Mip_Filter,
	s_address:         MSL_Sampler_Address,
	t_address:         MSL_Sampler_Address,
	r_address:         MSL_Sampler_Address,
	compare_func:      MSL_Sampler_Compare_Func,
	border_color:      MSL_Sampler_Border_Color,
	lod_clamp_min:     f32,
	lod_clamp_max:     f32,
	max_anisotropy:    i32,
	compare_enable:    b8,
	lod_clamp_enable:  b8,
	anisotropy_enable: b8,
}

MSL_Sampler_YCBCR_Conversion :: struct {
	planes:          u32,
	resolution:      MSL_Format_Resolution,
	chroma_filter:   MSL_Sampler_Filter,
	x_chroma_offset: MSL_Chroma_Location,
	y_chroma_offset: MSL_Chroma_Location,
	swizzle:         [4]MSL_Component_Swizzle,
	ycbcr_model:     MSL_Sampler_YCBCR_Model_Conversion,
	ycbcr_range:     MSL_Sampler_YCBCR_Range,
	bpc:             u32,
}

HLSL_Binding_Flag :: enum u32 {
	PUSH_CONSTANT = 0,
	CBV           = 1,
	SRV           = 2,
	UAV           = 3,
	SAMPLER       = 4,
}
HLSL_Binding_Flags :: bit_set[HLSL_Binding_Flag;u32]

HLSL_Resource_Binding_Mapping :: struct {
	register_space:   u32,
	register_binding: u32,
}

HLSL_Resource_Binding :: struct {
	stage:    Execution_Model,
	desc_set: u32,
	binding:  u32,
	cbv:      HLSL_Resource_Binding_Mapping,
	uav:      HLSL_Resource_Binding_Mapping,
	srv:      HLSL_Resource_Binding_Mapping,
	sampler:  HLSL_Resource_Binding_Mapping,
}

Compiler_Option :: enum u32 {
	UNKNOWN                                        = 0,
	FORCE_TEMPORARY                                = 1 | COMPILER_OPTION_COMMON,
	FLATTEN_MULTIDIMENSIONAL_ARRAYS                = 2 | COMPILER_OPTION_COMMON,
	FIXUP_DEPTH_CONVENTION                         = 3 | COMPILER_OPTION_COMMON,
	FLIP_VERTEX_Y                                  = 4 | COMPILER_OPTION_COMMON,
	GLSL_SUPPORT_NONZERO_BASE_INSTANCE             = 5 | COMPILER_OPTION_GLSL,
	GLSL_SEPARATE_SHADER_OBJECTS                   = 6 | COMPILER_OPTION_GLSL,
	GLSL_ENABLE_420PACK_EXTENSION                  = 7 | COMPILER_OPTION_GLSL,
	GLSL_VERSION                                   = 8 | COMPILER_OPTION_GLSL,
	GLSL_ES                                        = 9 | COMPILER_OPTION_GLSL,
	GLSL_VULKAN_SEMANTICS                          = 10 | COMPILER_OPTION_GLSL,
	GLSL_ES_DEFAULT_FLOAT_PRECISION_HIGHP          = 11 | COMPILER_OPTION_GLSL,
	GLSL_ES_DEFAULT_INT_PRECISION_HIGHP            = 12 | COMPILER_OPTION_GLSL,
	HLSL_SHADER_MODEL                              = 13 | COMPILER_OPTION_HLSL,
	HLSL_POINT_SIZE_COMPAT                         = 14 | COMPILER_OPTION_HLSL,
	HLSL_POINT_COORD_COMPAT                        = 15 | COMPILER_OPTION_HLSL,
	HLSL_SUPPORT_NONZERO_BASE_VERTEX_BASE_INSTANCE = 16 | COMPILER_OPTION_HLSL,
	MSL_VERSION                                    = 17 | COMPILER_OPTION_MSL,
	MSL_TEXEL_BUFFER_TEXTURE_WIDTH                 = 18 | COMPILER_OPTION_MSL,

	/* Obsolete, use SWIZZLE_BUFFER_INDEX instead. */
	MSL_AUX_BUFFER_INDEX                           = 19 | COMPILER_OPTION_MSL,
	MSL_SWIZZLE_BUFFER_INDEX                       = 19 | COMPILER_OPTION_MSL,
	MSL_INDIRECT_PARAMS_BUFFER_INDEX               = 20 | COMPILER_OPTION_MSL,
	MSL_SHADER_OUTPUT_BUFFER_INDEX                 = 21 | COMPILER_OPTION_MSL,
	MSL_SHADER_PATCH_OUTPUT_BUFFER_INDEX           = 22 | COMPILER_OPTION_MSL,
	MSL_SHADER_TESS_FACTOR_OUTPUT_BUFFER_INDEX     = 23 | COMPILER_OPTION_MSL,
	MSL_SHADER_INPUT_WORKGROUP_INDEX               = 24 | COMPILER_OPTION_MSL,
	MSL_ENABLE_POINT_SIZE_BUILTIN                  = 25 | COMPILER_OPTION_MSL,
	MSL_DISABLE_RASTERIZATION                      = 26 | COMPILER_OPTION_MSL,
	MSL_CAPTURE_OUTPUT_TO_BUFFER                   = 27 | COMPILER_OPTION_MSL,
	MSL_SWIZZLE_TEXTURE_SAMPLES                    = 28 | COMPILER_OPTION_MSL,
	MSL_PAD_FRAGMENT_OUTPUT_COMPONENTS             = 29 | COMPILER_OPTION_MSL,
	MSL_TESS_DOMAIN_ORIGIN_LOWER_LEFT              = 30 | COMPILER_OPTION_MSL,
	MSL_PLATFORM                                   = 31 | COMPILER_OPTION_MSL,
	MSL_ARGUMENT_BUFFERS                           = 32 | COMPILER_OPTION_MSL,
	GLSL_EMIT_PUSH_CONSTANT_AS_UNIFORM_BUFFER      = 33 | COMPILER_OPTION_GLSL,
	MSL_TEXTURE_BUFFER_NATIVE                      = 34 | COMPILER_OPTION_MSL,
	GLSL_EMIT_UNIFORM_BUFFER_AS_PLAIN_UNIFORMS     = 35 | COMPILER_OPTION_GLSL,
	MSL_BUFFER_SIZE_BUFFER_INDEX                   = 36 | COMPILER_OPTION_MSL,
	EMIT_LINE_DIRECTIVES                           = 37 | COMPILER_OPTION_COMMON,
	MSL_MULTIVIEW                                  = 38 | COMPILER_OPTION_MSL,
	MSL_VIEW_MASK_BUFFER_INDEX                     = 39 | COMPILER_OPTION_MSL,
	MSL_DEVICE_INDEX                               = 40 | COMPILER_OPTION_MSL,
	MSL_VIEW_INDEX_FROM_DEVICE_INDEX               = 41 | COMPILER_OPTION_MSL,
	MSL_DISPATCH_BASE                              = 42 | COMPILER_OPTION_MSL,
	MSL_DYNAMIC_OFFSETS_BUFFER_INDEX               = 43 | COMPILER_OPTION_MSL,
	MSL_TEXTURE_1D_AS_2D                           = 44 | COMPILER_OPTION_MSL,
	MSL_ENABLE_BASE_INDEX_ZERO                     = 45 | COMPILER_OPTION_MSL,

	/* Obsolete. Use MSL_FRAMEBUFFER_FETCH_SUBPASS instead. */
	MSL_IOS_FRAMEBUFFER_FETCH_SUBPASS              = 46 | COMPILER_OPTION_MSL,
	MSL_FRAMEBUFFER_FETCH_SUBPASS                  = 46 | COMPILER_OPTION_MSL,
	MSL_INVARIANT_FP_MATH                          = 47 | COMPILER_OPTION_MSL,
	MSL_EMULATE_CUBEMAP_ARRAY                      = 48 | COMPILER_OPTION_MSL,
	MSL_ENABLE_DECORATION_BINDING                  = 49 | COMPILER_OPTION_MSL,
	MSL_FORCE_ACTIVE_ARGUMENT_BUFFER_RESOURCES     = 50 | COMPILER_OPTION_MSL,
	MSL_FORCE_NATIVE_ARRAYS                        = 51 | COMPILER_OPTION_MSL,
	ENABLE_STORAGE_IMAGE_QUALIFIER_DEDUCTION       = 52 | COMPILER_OPTION_COMMON,
	HLSL_FORCE_STORAGE_BUFFER_AS_UAV               = 53 | COMPILER_OPTION_HLSL,
	FORCE_ZERO_INITIALIZED_VARIABLES               = 54 | COMPILER_OPTION_COMMON,
	HLSL_NONWRITABLE_UAV_TEXTURE_AS_SRV            = 55 | COMPILER_OPTION_HLSL,
	MSL_ENABLE_FRAG_OUTPUT_MASK                    = 56 | COMPILER_OPTION_MSL,
	MSL_ENABLE_FRAG_DEPTH_BUILTIN                  = 57 | COMPILER_OPTION_MSL,
	MSL_ENABLE_FRAG_STENCIL_REF_BUILTIN            = 58 | COMPILER_OPTION_MSL,
	MSL_ENABLE_CLIP_DISTANCE_USER_VARYING          = 59 | COMPILER_OPTION_MSL,
	HLSL_ENABLE_16BIT_TYPES                        = 60 | COMPILER_OPTION_HLSL,
	MSL_MULTI_PATCH_WORKGROUP                      = 61 | COMPILER_OPTION_MSL,
	MSL_SHADER_INPUT_BUFFER_INDEX                  = 62 | COMPILER_OPTION_MSL,
	MSL_SHADER_INDEX_BUFFER_INDEX                  = 63 | COMPILER_OPTION_MSL,
	MSL_VERTEX_FOR_TESSELLATION                    = 64 | COMPILER_OPTION_MSL,
	MSL_VERTEX_INDEX_TYPE                          = 65 | COMPILER_OPTION_MSL,
	GLSL_FORCE_FLATTENED_IO_BLOCKS                 = 66 | COMPILER_OPTION_GLSL,
	MSL_MULTIVIEW_LAYERED_RENDERING                = 67 | COMPILER_OPTION_MSL,
	MSL_ARRAYED_SUBPASS_INPUT                      = 68 | COMPILER_OPTION_MSL,
	MSL_R32UI_LINEAR_TEXTURE_ALIGNMENT             = 69 | COMPILER_OPTION_MSL,
	MSL_R32UI_ALIGNMENT_CONSTANT_ID                = 70 | COMPILER_OPTION_MSL,
	HLSL_FLATTEN_MATRIX_VERTEX_INPUT_SEMANTICS     = 71 | COMPILER_OPTION_HLSL,
	MSL_IOS_USE_SIMDGROUP_FUNCTIONS                = 72 | COMPILER_OPTION_MSL,
	MSL_EMULATE_SUBGROUPS                          = 73 | COMPILER_OPTION_MSL,
	MSL_FIXED_SUBGROUP_SIZE                        = 74 | COMPILER_OPTION_MSL,
	MSL_FORCE_SAMPLE_RATE_SHADING                  = 75 | COMPILER_OPTION_MSL,
	MSL_IOS_SUPPORT_BASE_VERTEX_INSTANCE           = 76 | COMPILER_OPTION_MSL,
	GLSL_OVR_MULTIVIEW_VIEW_COUNT                  = 77 | COMPILER_OPTION_GLSL,
	RELAX_NAN_CHECKS                               = 78 | COMPILER_OPTION_COMMON,
	MSL_RAW_BUFFER_TESE_INPUT                      = 79 | COMPILER_OPTION_MSL,
	MSL_SHADER_PATCH_INPUT_BUFFER_INDEX            = 80 | COMPILER_OPTION_MSL,
	MSL_MANUAL_HELPER_INVOCATION_UPDATES           = 81 | COMPILER_OPTION_MSL,
	MSL_CHECK_DISCARDED_FRAG_STORES                = 82 | COMPILER_OPTION_MSL,
	GLSL_ENABLE_ROW_MAJOR_LOAD_WORKAROUND          = 83 | COMPILER_OPTION_GLSL,
	MSL_ARGUMENT_BUFFERS_TIER                      = 84 | COMPILER_OPTION_MSL,
	MSL_SAMPLE_DREF_LOD_ARRAY_AS_GRAD              = 85 | COMPILER_OPTION_MSL,
	MSL_READWRITE_TEXTURE_FENCES                   = 86 | COMPILER_OPTION_MSL,
	MSL_REPLACE_RECURSIVE_INPUTS                   = 87 | COMPILER_OPTION_MSL,
	MSL_AGX_MANUAL_CUBE_GRAD_FIXUP                 = 88 | COMPILER_OPTION_MSL,
	MSL_FORCE_FRAGMENT_WITH_SIDE_EFFECTS_EXECUTION = 89 | COMPILER_OPTION_MSL,
	HLSL_USE_ENTRY_POINT_NAME                      = 90 | COMPILER_OPTION_HLSL,
	HLSL_PRESERVE_STRUCTURED_BUFFERS               = 91 | COMPILER_OPTION_HLSL,
	MSL_AUTO_DISABLE_RASTERIZATION                 = 92 | COMPILER_OPTION_MSL,
	MSL_ENABLE_POINT_SIZE_DEFAULT                  = 93 | COMPILER_OPTION_MSL,
	HLSL_USER_SEMANTIC                             = 94 | COMPILER_OPTION_HLSL,
}

@(link_prefix = "spvc_", default_calling_convention = "c")
foreign lib {
	get_version :: proc(major: ^u32, minor: ^u32, patch: ^u32) ---
	get_commit_revision_and_timestamp :: proc() -> cstring ---

	/* DEPRECATED */
	msl_vertex_attribute_init :: proc(attr: ^MSL_Vertex_Attribute) ---
	msl_shader_interface_var_init :: proc(var: ^MSL_Shader_Interface_Var) ---
	msl_shader_input_init :: proc(input: ^MSL_Shader_Interface_Var) ---

	msl_shader_interface_var_init_2 :: proc(var: ^MSL_Shader_Interface_Var_2) ---

	msl_resource_binding_init :: proc(binding: ^MSL_Resource_Binding) ---
	msl_resource_binding_init_2 :: proc(binding: ^MSL_Resource_Binding_2) ---

	msl_get_aux_buffer_struct_version :: proc() -> u32 ---
	msl_constexpr_sampler_init :: proc(sampler: ^MSL_Constexpr_Sampler) ---
	msl_sampler_ycbcr_conversion_init :: proc(conv: ^MSL_Sampler_YCBCR_Conversion) ---

	hlsl_resource_binding_init :: proc(binding: ^HLSL_Resource_Binding) ---

	context_create :: proc(ctx: ^Context) -> Result ---
	context_destroy :: proc(ctx: Context) ---
	context_release_allocations :: proc(ctx: Context) ---
	context_get_last_error_string :: proc(ctx: Context) -> cstring ---
	context_set_error_callback :: proc(ctx: Context, cb: proc "c" (userdata: rawptr, error: cstring), userdata: rawptr) ---
	context_parse_spirv :: proc(ctx: Context, spirv: ^u32, word_count: uint, parsed_ir: ^Parsed_IR) -> Result ---
	context_create_compiler :: proc(ctx: Context, backend: Backend, parsed_ir: Parsed_IR, mode: Capture_Mode, compiler: ^Compiler) -> Result ---

	compiler_get_current_id_bound :: proc(compiler: Compiler) -> u32 ---
	compiler_create_compiler_options :: proc(compiler: Compiler, options: ^Compiler_Options) -> Result ---
	compiler_options_set_bool :: proc(options: Compiler_Options, option: Compiler_Option, value: b8) -> Result ---
	compiler_options_set_uint :: proc(options: Compiler_Options, option: Compiler_Option, value: u32) -> Result ---
	compiler_install_compiler_options :: proc(compiler: Compiler, options: Compiler_Options) -> Result ---
	compiler_compile :: proc(compiler: Compiler, source: [^]cstring) -> Result ---
	compiler_add_header_line :: proc(compiler: Compiler, line: cstring) -> Result ---
	compiler_require_extension :: proc(compiler: Compiler, ext: cstring) -> Result ---
	compiler_get_num_required_extensions :: proc(compiler: Compiler) -> uint ---
	compiler_get_required_extension :: proc(compiler: Compiler, index: uint) -> cstring ---
	compiler_flatten_buffer_block :: proc(compiler: Compiler, id: Variable_ID) -> Result ---
	compiler_variable_is_depth_or_compare :: proc(compiler: Compiler, id: Variable_ID) -> b8 ---
	compiler_mask_stage_output_by_location :: proc(compiler: Compiler, location: u32, component: u32) -> Result ---
	compiler_mask_stage_output_by_builtin :: proc(compiler: Compiler, builtin: Built_In) -> Result ---

	// HLSL specifics.
	compiler_hlsl_set_root_constants_layout :: proc(compiler: Compiler, constant_info: [^]HLSL_Root_Constants, count: uint) -> Result ---
	compiler_hlsl_add_vertex_attribute_remap :: proc(compiler: Compiler, remap: [^]HLSL_Vertex_Attribute_Remap, remaps: uint) -> Result ---
	compiler_hlsl_remap_num_workgroups_builtin :: proc(compiler: Compiler) -> Variable_ID ---
	compiler_hlsl_set_resource_binding_flags :: proc(compiler: Compiler, flags: HLSL_Binding_Flags) -> Result ---
	compiler_hlsl_add_resource_binding :: proc(compiler: Compiler, #by_ptr binding: HLSL_Resource_Binding) -> Result ---
	compiler_hlsl_is_resource_used :: proc(compiler: Compiler, model: Execution_Model, set: u32, binding: u32) -> b8 ---

	// MSL specifics.
	compiler_msl_is_rasterization_disabled :: proc(compiler: Compiler) -> b8 ---
	// Obsolete, use `compiler_msl_needs_swizzle_buffer`.
	compiler_msl_needs_aux_buffer :: proc(compiler: Compiler) -> b8 ---
	compiler_msl_needs_swizzle_buffer :: proc(compiler: Compiler) -> b8 ---
	compiler_msl_needs_buffer_size_buffer :: proc(compiler: Compiler) -> b8 ---
	compiler_msl_needs_output_buffer :: proc(compiler: Compiler) -> b8 ---
	compiler_msl_needs_patch_output_buffer :: proc(compiler: Compiler) -> b8 ---
	compiler_msl_needs_input_threadgroup_mem :: proc(compiler: Compiler) -> b8 ---
	compiler_msl_add_vertex_attribute :: proc(compiler: Compiler, attrs: [^]MSL_Vertex_Attribute) -> Result ---
	// Deprecated, use `compiler_msl_add_resource_binding_2`.
	compiler_msl_add_resource_binding :: proc(compiler: Compiler, #by_ptr binding: MSL_Resource_Binding) -> Result ---
	compiler_msl_add_resource_binding_2 :: proc(compiler: Compiler, #by_ptr binding: MSL_Resource_Binding_2) -> Result ---
	// Deprecated, use `compiler_msl_add_shader_input_2`.
	compiler_msl_add_shader_input :: proc(compiler: Compiler, #by_ptr input: MSL_Shader_Interface_Var) -> Result ---
	compiler_msl_add_shader_input_2 :: proc(compiler: Compiler, #by_ptr input: MSL_Shader_Interface_Var_2) -> Result ---
	// Deprecated, use `compiler_msl_add_shader_output_2`.
	compiler_msl_add_shader_output :: proc(compiler: Compiler, #by_ptr output: MSL_Shader_Interface_Var) -> Result ---
	compiler_msl_add_shader_output_2 :: proc(compiler: Compiler, #by_ptr output: MSL_Shader_Interface_Var_2) -> Result ---
	compiler_msl_add_discrete_descriptor_set :: proc(compiler: Compiler, desc_set: u32) -> Result ---
	compiler_msl_set_argument_buffer_device_address_space :: proc(compiler: Compiler, desc_set: u32, device_address: b8) -> Result ---
	// Obsolete, use `compiler_msl_is_shader_input_used`.
	compiler_msl_is_vertex_attribute_used :: proc(compiler: Compiler, location: u32) -> b8 ---
	compiler_msl_is_shader_input_used :: proc(compiler: Compiler, location: u32) -> b8 ---
	compiler_msl_is_shader_output_used :: proc(compiler: Compiler, location: u32) -> b8 ---
	compiler_msl_is_resource_used :: proc(compiler: Compiler, model: Execution_Model, set: u32, binding: u32) -> b8 ---
	compiler_msl_remap_constexpr_sampler :: proc(compiler: Compiler, id: Variable_ID, #by_ptr sampler: MSL_Constexpr_Sampler) -> Result ---
	compiler_msl_remap_constexpr_sampler_by_binding :: proc(compiler: Compiler, desc_set: u32, binding: u32, #by_ptr sampler: MSL_Constexpr_Sampler) -> Result ---
	compiler_msl_remap_constexpr_sampler_ycbcr :: proc(compiler: Compiler, id: Variable_ID, #by_ptr sampler: MSL_Constexpr_Sampler, #by_ptr conv: MSL_Sampler_YCBCR_Conversion) -> Result ---
	compiler_msl_remap_constexpr_sampler_by_binding_ycbcr :: proc(compiler: Compiler, desc_set: u32, binding: u32, #by_ptr sampler: MSL_Constexpr_Sampler, #by_ptr conv: MSL_Sampler_YCBCR_Conversion) -> Result ---
	compiler_msl_set_fragment_output_components :: proc(compiler: Compiler, location: u32, components: u32) -> Result ---
	compiler_msl_get_automatic_resource_binding :: proc(compiler: Compiler, id: Variable_ID) -> u32 ---
	compiler_msl_get_automatic_resource_binding_secondary :: proc(compiler: Compiler, id: Variable_ID) -> u32 ---
	compiler_msl_add_dynamic_buffer :: proc(compiler: Compiler, desc_set: u32, binding: u32, index: u32) -> Result ---
	compiler_msl_add_inline_uniform_block :: proc(compiler: Compiler, desc_set: u32, binding: u32) -> Result ---
	compiler_msl_set_combined_sampler_suffix :: proc(compiler: Compiler, suffix: cstring) -> Result ---
	compiler_msl_get_combined_sampler_suffix :: proc(compiler: Compiler) -> cstring ---

	// Reflection.
	compiler_get_active_interface_variables :: proc(compiler: Compiler, set: ^Set) -> Result ---
	compiler_set_enabled_interface_variables :: proc(compiler: Compiler, set: Set) -> Result ---
	compiler_create_shader_resources :: proc(compiler: Compiler, resources: ^Resources) -> Result ---
	compiler_create_shader_resources_for_active_variables :: proc(compiler: Compiler, resources: ^Resources, active: Set) -> Result ---
	resources_get_resource_list_for_type :: proc(resources: Resources, type: Resource_Type, resource_list: [^]^Reflected_Resource, resource_size: ^uint) -> Result ---
	resources_get_builtin_resource_list_for_type :: proc(resources: Resources, type: Builtin_Resource_Type, resource_list: [^]^Reflected_Builtin_Resource, resource_size: ^uint) -> Result ---

	// Decorations.
	compiler_set_decoration :: proc(compiler: Compiler, id: u32, decoration: Decoration, argument: u32) ---
	compiler_set_decoration_string :: proc(compiler: Compiler, id: u32, decoration: Decoration, argument: cstring) ---
	compiler_set_name :: proc(compiler: Compiler, id: u32, argument: cstring) ---
	compiler_set_member_decoration :: proc(compiler: Compiler, id: Type_ID, member_index: u32, decoration: Decoration, argument: u32) ---
	compiler_set_member_decoration_string :: proc(compiler: Compiler, id: Type_ID, member_index: u32, decoration: Decoration, argument: cstring) ---
	compiler_set_member_name :: proc(compiler: Compiler, id: Type_ID, member_index: u32, argument: cstring) ---
	compiler_unset_decoration :: proc(compiler: Compiler, id: u32, decoration: Decoration) ---
	compiler_unset_member_decoration :: proc(compiler: Compiler, id: Type_ID, member_index: u32, decoration: Decoration) ---
	compiler_has_decoration :: proc(compiler: Compiler, id: u32, decoration: Decoration) -> b8 ---
	compiler_has_member_decoration :: proc(compiler: Compiler, id: Type_ID, member_index: u32, decoration: Decoration) -> b8 ---
	compiler_get_name :: proc(compiler: Compiler, id: u32) -> cstring ---
	compiler_get_decoration :: proc(compiler: Compiler, id: u32, decoration: Decoration) -> u32 ---
	compiler_get_decoration_string :: proc(compiler: Compiler, id: u32, decoration: Decoration) -> cstring ---
	compiler_get_member_decoration :: proc(compiler: Compiler, id: Type_ID, member_index: u32, decoration: Decoration) -> u32 ---
	compiler_get_member_decoration_string :: proc(compiler: Compiler, id: Type_ID, member_index: u32, decoration: Decoration) -> cstring ---
	compiler_get_member_name :: proc(compiler: Compiler, id: Type_ID, member_index: u32) -> cstring ---

	// Entry points.
	compiler_get_entry_points :: proc(compiler: Compiler, entry_points: [^]^Entry_Point, num_entry_points: ^uint) -> Result ---
	compiler_set_entry_point :: proc(compiler: Compiler, name: cstring, model: Execution_Model) -> Result ---
	compiler_rename_entry_point :: proc(compiler: Compiler, old_name: cstring, new_name: cstring, model: Execution_Model) -> Result ---
	compiler_get_cleansed_entry_point_name :: proc(compiler: Compiler, name: cstring, model: Execution_Model) -> cstring ---
	compiler_set_execution_mode :: proc(compiler: Compiler, mode: Execution_Mode) ---
	compiler_unset_execution_mode :: proc(compiler: Compiler, mode: Execution_Mode) ---
	compiler_set_execution_mode_with_arguments :: proc(compiler: Compiler, mode: Execution_Mode, arg0: u32, arg1: u32, arg2: u32) ---
	compiler_get_execution_modes :: proc(compiler: Compiler, modes: [^]^Execution_Mode, num_modes: ^uint) -> Result ---
	compiler_get_execution_mode_argument :: proc(compiler: Compiler, mode: Execution_Mode) -> u32 ---
	compiler_get_execution_mode_argument_by_index :: proc(compiler: Compiler, mode: Execution_Mode, index: u32) -> u32 ---
	compiler_get_execution_model :: proc(compiler: Compiler) -> Execution_Model ---
	compiler_update_active_builtins :: proc(compiler: Compiler) ---
	compiler_has_active_builtin :: proc(compiler: Compiler, builtin: Built_In, storage: Storage_Class) -> b8 ---

	compiler_get_type_handle :: proc(compiler: Compiler, id: Type_ID) -> Type ---
	type_get_base_type_id :: proc(type: Type) -> Type_ID ---
	type_get_basetype :: proc(type: Type) -> Base_Type ---
	type_get_bit_width :: proc(type: Type) -> u32 ---
	type_get_vector_size :: proc(type: Type) -> u32 ---
	type_get_columns :: proc(type: Type) -> u32 ---
	type_get_num_array_dimensions :: proc(type: Type) -> u32 ---
	type_array_dimension_is_literal :: proc(type: Type, dimension: u32) -> b8 ---
	type_get_array_dimension :: proc(type: Type, dimension: u32) -> u32 ---
	type_get_num_member_types :: proc(type: Type) -> u32 ---
	type_get_member_type :: proc(type: Type, index: u32) -> Type_ID ---
	type_get_storage_class :: proc(type: Type) -> Storage_Class ---

	// Image type query.
	type_get_image_sampled_type :: proc(type: Type) -> Type_ID ---
	type_get_image_dimension :: proc(type: Type) -> Dim ---
	type_get_image_is_depth :: proc(type: Type) -> b8 ---
	type_get_image_arrayed :: proc(type: Type) -> b8 ---
	type_get_image_multisampled :: proc(type: Type) -> b8 ---
	type_get_image_is_storage :: proc(type: Type) -> b8 ---
	type_get_image_storage_format :: proc(type: Type) -> Image_Format ---
	type_get_image_access_qualifier :: proc(type: Type) -> Access_Qualifier ---

	// Buffer layout query.
	compiler_get_declared_struct_size :: proc(compiler: Compiler, struct_type: Type, size: ^uint) -> Result ---
	compiler_get_declared_struct_size_runtime_array :: proc(compiler: Compiler, struct_type: Type, array_size: uint, size: ^uint) -> Result ---
	compiler_get_declared_struct_member_size :: proc(compiler: Compiler, type: Type, index: u32, size: ^uint) -> Result ---
	compiler_type_struct_member_offset :: proc(compiler: Compiler, type: Type, index: u32, offset: ^u32) -> Result ---
	compiler_type_struct_member_array_stride :: proc(compiler: Compiler, type: Type, index: u32, stride: ^u32) -> Result ---
	compiler_type_struct_member_matrix_stride :: proc(compiler: Compiler, type: Type, index: u32, stride: ^u32) -> Result ---

	// Workaround helper functions.
	compiler_build_dummy_sampler_for_combined_images :: proc(compiler: Compiler, id: ^Variable_ID) -> Result ---
	compiler_build_combined_image_samplers :: proc(compiler: Compiler) -> Result ---
	compiler_get_combined_image_samplers :: proc(compiler: Compiler, samplers: ^[^]Combined_Image_Sampler, num_samplers: ^uint) -> Result ---

	// Constants.
	compiler_get_specialization_constants :: proc(compiler: Compiler, constants: ^[^]Specialization_Constant, num_constants: ^uint) -> Result ---
	compiler_get_constant_handle :: proc(compiler: ^Compiler, id: Constant_ID) -> Constant ---
	compiler_get_work_group_size_specialization_constants :: proc(compiler: Compiler, x: ^Specialization_Constant, y: ^Specialization_Constant, z: ^Specialization_Constant) -> Constant_ID ---

	// Buffer ranges.
	compiler_get_active_buffer_ranges :: proc(compiler: Compiler, id: Variable_ID, ranges: ^[^]Buffer_Range, num_ranges: ^uint) -> Result ---

	constant_get_scalar_fp16 :: proc(constant: Constant, column: u32, row: u32) -> f32 ---
	constant_get_scalar_fp32 :: proc(constant: Constant, column: u32, row: u32) -> f32 ---
	constant_get_scalar_fp64 :: proc(constant: Constant, column: u32, row: u32) -> f64 ---
	constant_get_scalar_u32 :: proc(constant: Constant, column: u32, row: u32) -> u32 ---
	constant_get_scalar_i32 :: proc(constant: Constant, column: u32, row: u32) -> i32 ---
	constant_get_scalar_u16 :: proc(constant: Constant, column: u32, row: u32) -> u32 ---
	constant_get_scalar_i16 :: proc(constant: Constant, column: u32, row: u32) -> i32 ---
	constant_get_scalar_u8 :: proc(constant: Constant, column: u32, row: u32) -> u32 ---
	constant_get_scalar_i8 :: proc(constant: Constant, column: u32, row: u32) -> i32 ---
	constant_get_subconstants :: proc(constant: Constant, constituents: ^[^]Constant_ID, count: ^uint) ---
	constant_get_scalar_u64 :: proc(constant: Constant, column: u32, row: u32) -> u64 ---
	constant_get_scalar_i64 :: proc(constant: Constant, column: u32, row: u32) -> i64 ---
	constant_get_type :: proc(constant: Constant) -> Type_ID ---

	constant_set_scalar_fp16 :: proc(constant: Constant, column: u32, row: u32, value: u16) ---
	constant_set_scalar_fp32 :: proc(constant: Constant, column: u32, row: u32, value: f32) ---
	constant_set_scalar_fp64 :: proc(constant: Constant, column: u32, row: u32, value: f64) ---
	constant_set_scalar_u32 :: proc(constant: Constant, column: u32, row: u32, value: u32) ---
	constant_set_scalar_i32 :: proc(constant: Constant, column: u32, row: u32, value: i32) ---
	constant_set_scalar_u64 :: proc(constant: Constant, column: u32, row: u32, value: u64) ---
	constant_set_scalar_i64 :: proc(constant: Constant, column: u32, row: u32, value: i64) ---
	constant_set_scalar_u16 :: proc(constant: Constant, column: u32, row: u32, value: u16) ---
	constant_set_scalar_i16 :: proc(constant: Constant, column: u32, row: u32, value: i16) ---
	constant_set_scalar_u8 :: proc(constant: Constant, column: u32, row: u32, value: u8) ---
	constant_set_scalar_i8 :: proc(constant: Constant, column: u32, row: u32, value: i8) ---

	compiler_get_binary_offset_for_decoration :: proc(compiler: Compiler, id: Variable_ID, decoration: Decoration, word_offset: ^u32) -> b8 ---
	compiler_buffer_is_hlsl_counter_buffer :: proc(compiler: Compiler, id: Variable_ID) -> b8 ---
	compiler_buffer_get_hlsl_counter_buffer :: proc(compiler: Compiler, id: Variable_ID, counter_id: ^Variable_ID) -> b8 ---
	compiler_get_declared_capabilities :: proc(compiler: Compiler, capabilities: ^[^]Capability, num_capabilities: ^uint) -> Result ---
	compiler_get_declared_extensions :: proc(compiler: Compiler, extensions: ^[^]cstring, num_extensions: ^uint) -> Result ---
	compiler_get_remapped_declared_block_name :: proc(compiler: Compiler, id: Variable_ID) -> cstring ---
	compiler_get_buffer_block_decorations :: proc(compiler: Compiler, id: Variable_ID, decorations: ^[^]Decoration, num_decorations: ^uint) -> Result ---
}
