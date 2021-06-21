install_dir=${HOME}/opt
echo "Installing fzf into ${install_dir}..."
mkdir -p ${install_dir}
git clone --depth 1 https://github.com/junegunn/fzf.git ${install_dir}/fzf
${install_dir}/fzf/install
echo "DONE."
